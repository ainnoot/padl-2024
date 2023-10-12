from pathlib import Path
from itertools import combinations, product
import sys
from difflib import Differ

methods = ['asp_native', 'ltlf_base','automata', 'd4py']

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def print_ok(*args):
	print(bcolors.BOLD, bcolors.OKGREEN, *args, bcolors.ENDC)

def print_fail(*args):
	print(bcolors.BOLD, bcolors.FAIL, *args, bcolors.ENDC)

def print_(*args, match):
	if match:
		print_ok(*args)
	else:
		print_fail(*args)


qc_templates = [
	'Responded_Existence',
	'Co-Existence',
	'Response',
	'Precedence',
	'Succession',
	'Alternate_Response',
	'Alternate_Precedence',
	'Alternate_Succession',
	'Chain_Response',
	'Chain_Precedence',
	'Chain_Succession',
	'Choice',
	'Exclusive_Choice'
]

supports = [0.5, 0.75, 1.0]

def parse_qc(path):
	prg = []
	text = [l.strip() for l in path.read_text().split('\n') if len(l.strip()) > 0]

	prg.append(text[0].split(' ')[1])
	for line in text[1:]:
		prg.append(line.split(' ')[1])
	return sorted(prg)
		

def split_strip_and_sort(text):
	lines = [t.strip() for t in text.split('\n') if len(text.strip()) > 0]
	return sorted(lines)

if __name__ == '__main__':
	results_path = Path(sys.argv[1])
	d = Differ()

	### Conformance checking
	for log_folder in (results_path / 'cf').glob('*'):
		print("Found the following methods for conformance checking on {}: {}".format(log_folder.stem, methods))
		for method_1, method_2 in combinations(methods, 2):
			print("Comparing {} and {} on {}".format(method_1, method_2, log_folder.stem))
			splits_1 = set(x.stem for x in Path(log_folder / method_1).glob('*'))
			splits_2 = set(x.stem for x in Path(log_folder / method_2).glob('*'))
			result = splits_1 == splits_2
			print_("  * Computed same sets of things?", splits_1 == splits_2, match=result)

			for item in splits_1:				
				text_1 = split_strip_and_sort(Path(log_folder / method_1 / item).read_text())
				text_2 = split_strip_and_sort(Path(log_folder / method_2 / item).read_text())
				result = text_1 == text_2
				print_("  * Match on {}? {}".format(item, result), match=result)
	print()


	for log_folder in (results_path / 'qc').glob('*'):
		print("Found the following methods for query checking on {}: {}".format(log_folder.stem, methods))
		for method_1, method_2 in combinations(methods, 2):
			print("Comparing {} and {} over {}".format(method_1, method_2, log_folder.stem))
			for template, support in product(qc_templates, supports):
				try:
					filename = '{}_{}'.format(template, support)
					text_1 = parse_qc(log_folder / method_1 / filename)
					text_2 = parse_qc(log_folder / method_2 / filename)
					result = text_1 == text_2				
					print_("  * Match on {}? {}".format(filename, result), match=result)
				except:
					print_("  * Empty ans [It's expected for D4Py sometimes...]?", filename, match=False)
