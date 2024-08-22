import sys
import os
from itertools import product
from pyrunlim import pyrunlim_launch
import pandas as pd

CONSTRAINTS = [
	"response",
	"precedence",
	"alternate_precedence",
	"alternate_response",
	"chain_precedence",
	"chain_response"
]

LENGTHS = [
	50,
	100,
	250,
	500
]

METHODS = [
	"d4py",
	"asp_native"
]

BASE_PATH = "additional_experiments"
LOG_PATH = os.path.join(BASE_PATH, "synthetic_logs")
MODEL_PATH = os.path.join(BASE_PATH, "declare_models")

def make_command(log, model, method):
	return ["python3", "conformance_checking.py", log, model, "-m", M, "-o", "/dev/null"]


rows = []
for C, L in product(CONSTRAINTS, LENGTHS):
	log = f"{LOG_PATH}/{C}_{L}.xes"
	model = f"{MODEL_PATH}/{C}.decl"
	command = make_command(log, model, 'd4py')
	p = pyrunlim_launch(command)

	d4py_real = p.real
	d4py_memo = p.max_memory

	command = make_command(log, model, 'asp_native')
	p = pyrunlim_launch(command)

	asp_real = p.real
	asp_memo = p.max_memory

	rows.append((C, L, d4py_real, asp_real, d4py_memo, asp_memo))

df = pd.DataFrame(rows, columns=["constraint", "length", "d4py_real", "asp_real", "d4py_memo", "asp_memo"])

df.to_csv("results.csv", index=False, header=True)
