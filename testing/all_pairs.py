import itertools
import os
from pathlib import Path

ENCODINGS = [
	'automata',
	'ltlf_base',
	'ltlf_xnf',
	'ltlf_dag',
	'ad_hoc'
]

BASE_DIR = Path(__file__).parent

for enc_1, enc_2 in itertools.combinations(ENCODINGS, 2):
	print("Searching counterexamples over DECLARE contraints for {} wrt {}".format(enc_1, enc_2))
	os.system("python3 testing/pairwise.py {} {}".format(enc_1, enc_2))
	print()
