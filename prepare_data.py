from pathlib import Path
import shutil
import sys
import warnings
import numpy as np
from typing import Dict, Tuple
from collections import defaultdict
from Declare4Py.ProcessModels.DeclareModel import DeclareModel
from Declare4Py.ProcessMiningTasks.Discovery.DeclareMiner import DeclareMiner
from Declare4Py.D4PyEventLog import D4PyEventLog
from time import time
from random import shuffle


def cut_models(constraints, thresholds):
	models = []
	integer_thresholds = [int(len(constraints) * thr) for thr in thresholds]

	for thr in thresholds:
		m = DeclareModel()
		end = int(len(constraints) * thr)
		m.constraints = constraints[0:end]
		m.set_constraints()
		models.append(m)

	return models

def remove_unsupported_constraints(constraints):
	OK_CONSTRAINTS = set([
		'Choice',
		'Exclusive Choice',
		'Responded Existence',
		'Co-Existence',
		'Response',
		'Alternate Response',
		'Chain Response',
		'Precedence',
		#'Alternate Precedence', TODO: D4Py has a wrong definition
		'Chain Precedence',
		'Succession',
		'Alternate Succession',
		'Chain Succession',
		'Not Resoponded Existence',
		'Not Co-Existence',
		'Not Succession',
		'Not Response',
		'Not Precedence',
		'Not Chain Succession'
		'Not Chain Response',
		'Not Chain Precedence',
	])

	filtered_constraints = []
	for c in constraints:
		if c['template'].templ_str in OK_CONSTRAINTS:
			filtered_constraints.append(c)
	return filtered_constraints

if __name__ == '__main__':
	warnings.simplefilter("ignore")

	if len(sys.argv) < 3:
		print("Usage: {} [source log dir] [target dir]")
		sys.exit(1)

	source_dir = Path(sys.argv[1])
	target_dir  = Path(sys.argv[2])

	PREPROCESSING_TIMES = {}
	D4PY_CONFORMANCE_CHECKING_TIMES = defaultdict(lambda: [], {})

	if not source_dir.exists():
		print("Source folder {} does not exist. Abort.".format(source_dir))
		sys.exit(1)

	print("Deleting all contents of target folder: {}".format(target_dir))
	shutil.rmtree(target_dir)

	for log in source_dir.glob('*.xes'):
		print("Processing log: {}".format(log))

		log_name = log.stem
		log_dir = Path(target_dir, log_name)
		log_dir.mkdir(parents=True)

		shutil.copy(log, log_dir / 'log.xes')

		models_dir = Path(log_dir / 'models')
		models_dir.mkdir(parents=True)

		# Mine Declare constraints
		now = time()
		event_log = D4PyEventLog(case_name="case:concept:name")
		event_log.parse_xes_log(log.as_posix())
		elapsed = time() - now
		print("D4Py log parsing time {:.3f}s".format(elapsed))
		supp_threshold = 0.5		

		now = time()
		miner = DeclareMiner(log=event_log, consider_vacuity=True, min_support=supp_threshold, max_declare_cardinality=1)
		all_constraints = miner.run()
		print("D4Py Mining Declare with min_support={}: {:.3f}s".format(supp_threshold, elapsed))

		# Remove unsupported constraints
		filtered_constraints = remove_unsupported_constraints(all_constraints.constraints)
		shuffle(filtered_constraints)

		print("Filtered down from {} to {} constraints".format(len(all_constraints.constraints), len(filtered_constraints)))

		# Cutting models
		thresholds = [0.25, 0.50, 0.75, 1.0]
		models = cut_models(filtered_constraints, thresholds)

		# Time to perform conformance checking with Declare4Py
		for split_idx, model in enumerate(models):
			model.to_file(str(models_dir / 'split_{}.decl'.format(split_idx)))

