import sys
import os
from pyrunlim import pyrunlim_launch
from memory_profiler import profile, memory_usage
from time import perf_counter

def run(model, log, method):
	outputs = dict()

	@profile
	def main_asp(model, log, method, outputs):
		import clingo
		start = perf_counter()

		ctl = clingo.Control()
		ctl.load(model)
		ctl.load(log)
		ctl.load(f'../{method}/semantics.lp')
		ctl.load(f'../{method}/templates.lp')
		ctl.ground([("base",[])])
		ans = ctl.solve()
		outputs['symbolic_atoms'] = len(ctl.symbolic_atoms)
		outputs['execution_time'] = ctl.statistics['summary']['times']['total']
		outputs['rules'] = ctl.statistics['problem']['lp']['rules']

		end = perf_counter()
		outputs['total_time'] = end - start

	@profile
	def main_d4py(model, log, method, outputs):
		from Declare4Py.D4PyEventLog import D4PyEventLog
		from Declare4Py.ProcessModels.DeclareModel import DeclareModel
		from Declare4Py.ProcessMiningTasks.ConformanceChecking.MPDeclareAnalyzer import MPDeclareAnalyzer

		# parse log
		start = perf_counter()
		d4py_log = D4PyEventLog()
		d4py_log.parse_xes_log(log)

		print("Done parsing log...!")
		outputs['parse_log'] = perf_counter() - start

		# parse decl
		declare_model = DeclareModel()
		declare_model.parse_from_file(model)

		# do the conformance checking
		checker = MPDeclareAnalyzer(log=d4py_log, declare_model=declare_model, consider_vacuity=True)
		ans = checker.run()

		end = perf_counter()
		outputs['total_time'] = end - start


	mem_usage = memory_usage((main_d4py if method == 'd4py' else main_asp, (model, log, method, outputs), dict()), interval=0.05)
	outputs['memory_peak'] = max(mem_usage)
	outputs['model'] = model
	outputs['log'] = log
	outputs['method'] = method

	return outputs

if __name__ == '__main__':
	if len(sys.argv) != 4:
		print("Usage: {} [MODEL] [LOG] [METHOD]".format(__file__))
		sys.exit(1)
	_, model, log, method = sys.argv
	o = run(model, log, method)

	print(o)
