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

rows = []
for C, L, M in product(CONSTRAINTS, LENGTHS, METHODS):
	log = f"{LOG_PATH}/{C}_{L}.xes"
	model = f"{MODEL_PATH}/{C}.decl"
	command = ["python3", "conformance_checking.py", log, model, "-m", M, "-o", "/dev/null"]
	p = pyrunlim_launch(command)

	rows.append((C, L, M, p.real, p.real, p.max_memory))


df = pd.DataFrame(rows, columns=["constraint", "length", "method", "real", "time", "max_memory"])

df.to_csv("results.csv", index=False, header=True)
