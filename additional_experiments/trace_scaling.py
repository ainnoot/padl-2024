import sys
import os
import clingo
from pathlib import Path
from memory_profiler import profile, memory_usage

def run_cf(model, method, log):
	ctl = clingo.Control()
	ctl.load(model)
	ctl.load(f'../{method}/templates.lp')
	ctl.load(f'../{method}/semantics.lp')
	ctl.load(log)
	ctl.ground([("base",[])])
	ans = ctl.solve()
	return {"total_time": ..., "symbols": ..., "rules": ...}

if __name__ == '__main__':
	if len(sys.argv) != 4 :
		print("Usage: {} [MODEL] [LOG_ROOT] [LOGS_GLOB_EXPR]".format(__file__))
		sys.exit(1)

	model = sys.argv[1]
	log_root = sys.argv[2]
	log_glob_expr = sys.argv[3]

	for method in ['asp_native', 'automata', 'ltlf_base']:
		for log in Path(log_root).glob(log_glob_expr):
			stats = run_cf(model, method, log.as_posix())
			stats["peak_memory"] = ...
			stats["method"] = method
			stats["log"] = log.as_posix()
			stats["model"] = model
			print("Done: {} {} {:.3f}s".format(method, log.as_posix(), elapsed))
			
