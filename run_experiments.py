from pathlib import Path
from pyrunlim import pyrunlim_launch
import sys
import shutil
import os

if __name__ == '__main__':
	data_folder = sys.argv[1]
	results_folder = sys.argv[2]

	shutil.rmtree(results_folder)
	Path(results_folder).mkdir(parents=True)

	methods = ['asp_native', 'd4py', 'ltlf_base', 'ltlf_xnf', 'automata']

	# Generate all pyrunlim cmd's
	jobs_to_be_executed = []

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


				jobs_to_be_executed.append(((cf_method, log_folder.stem, model.stem), cmd))



	from multiprocessing import Pool
	def launch_and_report(x):
		(method, log, split), cmd = x
		process_output = pyrunlim_launch(cmd)
		return "{} {} {} {:.3f} {:.3f}".format(method, log, split, process_output.real, process_output.max_memory)

	with Pool(16) as pool:
		res = pool.map(launch_and_report, jobs_to_be_executed)

	for line in res:
		print(line)





