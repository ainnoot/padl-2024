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

LOG_SIZE = 100
TRACE_LENGTHS = [50, 100, 250, 500]

MODEL_FOLDER = Path(sys.argv[1])
OUTPUT_FOLDER = Path(sys.argv[2])

models = list(MODEL_FOLDER.glob("*.lp"))
print("Found models:", models)

class LogCallback:
	def __init__(self):
		self.traces = []
		self.idx = 0

	def __call__(self, model):
		tid = clingo.Number(self.idx)
		for symbol in model.symbols(shown=True):
			t = symbol.arguments[1]
			a = symbol.arguments[2]
			self.traces.append(clingo.Function("trace", [tid, t, a]))
		self.idx += 1

	def save(self, path):
		with path.open('w') as f:
			for event in log.traces:
				f.write(str(event) + ".\n")
				f.flush()
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

		log = LogCallback()
		ctl.assign_external(clingo.Function("negative"), False)
		ans = ctl.solve(on_model=log)
		ctl.assign_external(clingo.Function("negative"), True)
		ans = ctl.solve(on_model=log)
		log.save(OUTPUT_FOLDER / log_name)

		print("Done generating:", log_name, "Size:", len(log.traces))


