from pathlib import Path
from pyrunlim import pyrunlim_launch
import sys
import shutil
import os
from multiprocessing import Pool

def launch_and_report(x):
	task, (template, log, method), cmd = x
	process_output = pyrunlim_launch(cmd)
	return "{} {} {} {} {:.3f} {:.3f}".format(task, template, log, method, process_output.real, process_output.max_memory)


if __name__ == '__main__':
	data_folder = Path(sys.argv[1])
	results_folder = Path(sys.argv[2], 'query_checking')
	logger_file = sys.argv[3]

        Path(results_folder).mkdir(parents=True)
	shutil.rmtree(results_folder)

	methods = ['asp_native', 'd4py', 'ltlf_base', 'automata']
	available_templates = [
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
		'Not Responded Existence',
		'Not Co-Existence',
		'Not Succession',
		'Not Response',
		'Not Precedence',
		'Not Chain Succession',
		'Not Chain Response',
		'Not Chain Precedence',
	]

	jobs_to_be_executed = []

	# Run conformance checking with all methods for all available logs and splits
	for log_folder in data_folder.glob('*'):
		log = Path(log_folder / 'log.xes')

		print("Found a log:", log_folder.stem)

		for qc_method in methods:
			for template in available_templates:
				for supp in [0.5, 0.75, 1.0]:
					# results/cf/sepsis/asp_native/split_3/ANS
					template_w_supp = '{}_{}'.format('_'.join(template.split(' ')), supp)
					output_folder = results_folder / log_folder.stem / qc_method
					output_folder.mkdir(parents=True, exist_ok=True)
					output_file = output_folder / template_w_supp
					output_file.touch()

					cmd = [
						"./query_checking.py", 
						log.as_posix(), 
						template,
						"--method={}".format(qc_method),
						"--output={}".format(str(output_file)),
						"--min-support={}".format(supp)
					]

					# Generate all pyrunlim cmd'			for line in res:
					jobs_to_be_executed.append(('query_checking', (template_w_supp, log_folder.stem, qc_method), cmd))

	with open(logger_file, 'w+') as f:
		for (task, params, cmd) in jobs_to_be_executed:
			res = launch_and_report((task,params,cmd))
			f.write(res+'\n')
			f.flush()


