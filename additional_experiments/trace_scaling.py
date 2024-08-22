import sys
import os
import clingo
from pathlib import Path
from memory_profiler import profile, memory_usage
from time import perf_counter

def run_cf(model, method, log):
	def g(model, method, log, outputs):
		from Declare4Py.D4PyEventLog import D4PyEventLog
		from Declare4Py.ProcessModels.DeclareModel import DeclareModel
		from Declare4Py.ProcessMiningTasks.ConformanceChecking.MPDeclareAnalyzer import MPDeclareAnalyzer

		# parse log
		start = perf_counter()
		d4py_log = D4PyEventLog()
		d4py_log.parse_xes_log(log)

		print("Read log?")

		print("Done parsing log...!")
		outputs['parse_log'] = perf_counter() - start

		# parse decl
		declare_model = DeclareModel()
		declare_model.parse_from_file(model)

		# do the conformance checking
		checker = MPDeclareAnalyzer(log=d4py_log, declare_model=declare_model, consider_vacuity=True)
		ans = checker.run().get_metric('state')

		end = perf_counter()
		outputs['total_time'] = end - start

	def f(model, method, log, outputs):
		ctl = clingo.Control()
		ctl.load(model)
		ctl.load(f'../{method}/templates.lp')
		ctl.load(f'../{method}/semantics.lp')
		ctl.load(log)
		ctl.ground([("base",[])])
		with ctl.solve(yield_=True) as hnd:
			m = hnd.model()

		outputs["symbolic_atoms"] = len(ctl.symbolic_atoms)
		outputs["execution_time"] = ctl.statistics["summary"]["times"]["total"]
		outputs["rules"] = ctl.statistics["problem"]["lp"]["rules"]

	outputs = dict()
	mem_usage = memory_usage((g if method == 'd4py' else f, (model, method, log, outputs), dict()), interval=0.05)
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

	for method in ['d4py']: #['asp_native', 'automata']: # 'ltlf_base']:
		for log in Path(log_root).glob(log_glob_expr):
			outputs = run_cf(model, method, log.as_posix())
			print(outputs)
