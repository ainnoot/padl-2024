from pathlib import Path
from pyrunlim import pyrunlim_launch
import sys
import shutil
import os

if __name__ == '__main__':
	data_folder = sys.argv[1]
	results_folder = sys.argv[2]
	logger = sys.argv[3]

	logger_file = open(logger, 'w+')

	shutil.rmtree(results_folder)
	Path(results_folder).mkdir(parents=True)

	methods = ['asp_native', 'd4py', 'ltlf_base', 'ltlf_xnf', 'automata']

	# Run conformance checking with all methods for all available logs and splits
	for log_folder in Path(data_folder).glob('*'):
		log = Path(log_folder / 'log.xes')
		models = list(Path(log_folder / 'models').glob('*.decl'))

		print("Found a log:", log_folder.stem)
		print("Available DECLARE models:")
		for model in models:
			print("\t*", model.stem)
		print()

		#### CONFORMANCE CHECKING	
		for model in sorted(models):
			for cf_method in methods:
				# results/cf/sepsis/asp_native/split_3/ANS
				output_folder = Path(results_folder, 'conformance_checking', log_folder.stem, cf_method, str(model.stem))
				output_folder.mkdir(parents=True)
				output_file = output_folder / 'ANS'
				output_file.touch()

				cmd = [
				"./conformance_checking.py", 
				log.as_posix(), 
				model.as_posix(), 
				"--method={}".format(cf_method),
				"--output={}".format(str(output_file))
				]
				print("Running cmd:", ' '.join(cmd))			
				run_result = pyrunlim_launch(cmd)

				logging_msg = ' '.join(['CONFORMANCE_CHECKING', cf_method, log_folder.stem, model.stem, str(run_result.real), str(run_result.max_memory)]) + '\n'
				logger_file.write(logging_msg)
				logger_file.flush()

	logger_file.close()





