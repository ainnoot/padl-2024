import Declare4Py
from Declare4Py.ProcessModels.DeclareModel import DeclareModel
from Declare4Py.ProcessMiningTasks.ASPLogGeneration.asp_generator import AspGenerator
from pathlib import Path 
import sys
import os
import clingo
import copy

if len(sys.argv) != 3:
	print("Usage: {} [model folder] [output folder]".format(__file__))
	sys.exit(1)

LOG_SIZE = 2000
TRACE_LENGTHS = [50, 100, 250, 500]

MODEL_FOLDER = Path(sys.argv[1])
OUTPUT_FOLDER = Path(sys.argv[2])

models = list(MODEL_FOLDER.glob("*.lp"))
print("Found models:", models)

class LogCallback:
	def __init__(self, output_path):
		self.fp = open(output_path, 'w')
		self.idx = 0

	def __call__(self, model):
		tid = self.idx
		for symbol in model.symbols(shown=True):
			t = symbol.arguments[1].number
			a = symbol.arguments[2].string
			self.fp.write("trace({},{},\"{}\").\n".format(tid,t,a))
		self.fp.flush()
		self.idx += 1

	def close_file(self, path):
		self.fp.close()

for model_file in models:
	for sz in TRACE_LENGTHS:
		ctl = clingo.Control(["-c", "t={}".format(sz)])
		ctl.load('generate.lp')
		ctl.load(model_file.as_posix())
		ctl.load('../asp_native/semantics.lp')
		ctl.ground([("base", [])])
		ctl.configuration.solve.models = LOG_SIZE // 2

		constraint_name = model_file.stem
		log_name = "{}_{}.lp".format(constraint_name, sz)

		log = LogCallback((OUTPUT_FOLDER / log_name).as_posix())
		ctl.assign_external(clingo.Function("negative"), False)
		ans = ctl.solve(on_model=log)
		ctl.assign_external(clingo.Function("negative"), True)
		ans = ctl.solve(on_model=log)

		print("Done generating:", log_name, "Size:", log.idx)


