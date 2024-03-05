import sys
import os
from pyrunlim import pyrunlim_launch
from memory_profiler import profile, memory_usage
import clingo

def run(model, log, method):
	outputs = dict()

	@profile
	def main(model, log, method, outputs):
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

	mem_usage = memory_usage((main, (model, log, method, outputs), dict()), , interval=0.05)
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
