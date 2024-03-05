import sys
import os
import clingo
from pathlib import Path
from memory_profiler import profile, memory_usage

def run_cf(model, method, log):

	def f(model, method, log, outputs):
		ctl = clingo.Control()
		ctl.load(model)
		ctl.load(f'../{method}/templates.lp')
		ctl.load(f'../{method}/semantics.lp')
		ctl.load(log)
		ctl.ground([("base",[])])
		ans = ctl.solve()
		outputs["symbolic_atoms"] = len(ctl.symbolic_atoms)
		outputs["execution_time"] = ctl.statistics["summary"]["times"]["total"]
		outputs["rules"] = ctl.statistics["problem"]["lp"]["rules"]

	outputs = dict()
	mem_usage = memory_usage((f, (model, method, log, outputs), dict()), interval=0.05)
	outputs["memory_peak"] = max(mem_usage)
	outputs["model"] = model
	outputs["log"] = log
	outputs["method"] = method

	return outputs

if __name__ == '__main__':
	if len(sys.argv) != 4 :
		print("Usage: {} [MODEL] [LOG_ROOT] [LOGS_GLOB_EXPR]".format(__file__))
		sys.exit(1)

	model = sys.argv[1]
	log_root = sys.argv[2]
	log_glob_expr = sys.argv[3]

	for method in ['asp_native', 'automata']: # 'ltlf_base']:
		for log in Path(log_root).glob(log_glob_expr):
			outputs = run_cf(model, method, log.as_posix())
			print(outputs)			
