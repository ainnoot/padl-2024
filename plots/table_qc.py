import numpy as np 
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import sys
from scipy import stats

df = pd.read_csv(sys.argv[1], names=("Template", "Support", "Log", "Method", "Time", "Max Memory"), sep=" ")


logs = sorted(df['Log'].unique())

latex_rows = []
for log in logs:
	latex_row = []
	for method in ['asp_native', 'd4py', 'automata', 'ltlf_base']:
		to_plot = df[(df['Method'] == method) & (df['Log'] == log)]
		latex_row.append(to_plot['Time'].sum())
	latex_rows.append((log, latex_row))

for log, times in latex_rows:
	times = ["{:.3f}".format(x) for x in times]
	print(' & '.join([log] + times) + '\\\\')
