from pathlib import Path
from pyrunlim import pyrunlim_launch
import sys
import shutil
import os
import argparse
from dataclasses import dataclass

METHODS = ['asp_native']

@dataclass(frozen=True)
class Arguments:
	data_folder: Path
	results_folder: Path
	log_folder: Path

def parse_args():
	p = argparse.ArgumentParser()
	p.add_argument('data_folder', type=str)
	p.add_argument('results_folder', type=str)
	p.add_argument('log_folder', type=str)

	args = p.parse_args()
	return Arguments(
		Path(args.data_folder),
		Path(args.results_folder),
		Path(args.log_folder)
	)

def log_generation_experiments():
	pass

def conformance_checking_experiments(args):
	f = (args.log_folder / 'cf').open('w')

	for log_folder in args.data_folder.glob('*'):
		log = log_folder / 'log.xes'
		log_name = log_folder.stem
		models_folder = log_folder / 'models'
		models = list(models_folder.glob('*.decl'))

		for model in sorted(models):
			for method in METHODS:
				output_folder = args.results_folder / 'cf' / log_name / method
				output_folder.mkdir(parents=True, exist_ok=True)
				output_file = output_folder / model.stem
				output_file.touch()

				cmd = [
					'./conformance_checking.py',
					log.as_posix(),
					model.as_posix(),
					'--method={}'.format(method),
					'--output={}'.format(output_file.as_posix())
				]

				p_out = pyrunlim_launch(cmd)
				f.write("{} {} {} {:.3f} {:.3f}\n".format(
					method,
					log_name,
					model.stem,
					p_out.real,
					p_out.max_memory
				))
				f.flush()
	f.close()

def query_checking_experiments(args):
	f = (args.log_folder / 'qc').open('w')

	templates_to_qc = [
        'Choice',
        'Exclusive Choice',
        'Responded Existence',
        'Co-Existence',
        'Response',
        'Alternate Response',
        'Chain Response',
        'Precedence',
        'Alternate Precedence',
        'Chain Precedence',
        'Succession',
        'Alternate Succession',
        'Chain Succession'
	]

	for log_folder in args.data_folder.glob('*'):
		log = log_folder / 'log.xes'
		log_name = log_folder.stem

		for method in METHODS:
			for template in templates_to_qc:
				for supp in [0.50, 0.75, 1.0]:
					template_w_supp = '_'.join(template.split(' ')) + '_{}'.format(supp)
					output_folder = args.results_folder / 'qc' / log_name / method
					output_folder.mkdir(parents=True, exist_ok=True)
					output_file = output_folder / template_w_supp
					output_file.touch()

					cmd = [
						'./query_checking.py',
						log.as_posix(),
						template,
						'--method={}'.format(method),
						'--output={}'.format(output_file.as_posix()),
						'--min-support={}'.format(supp)
					]

					p_out = pyrunlim_launch(cmd)
					f.write("{} {} {} {} {:.3f} {:.3f}\n".format(
						'_'.join(template.split(' ')),
						supp,
						log_name,
						method,
						p_out.real,
						p_out.max_memory
					))
					f.flush()
	f.close()


if __name__ == '__main__':
	args = parse_args()
	Path(args.log_folder).mkdir(exist_ok=True, parents=True)
	conformance_checking_experiments(args)
	query_checking_experiments(args)
