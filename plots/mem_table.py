import numpy as np 
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import sys

cf_df = pd.read_csv(sys.argv[1], names=("Method", "Log", "Model", "Time", "Max Memory"), sep=" ")
qc_df = pd.read_csv(sys.argv[2], names=("Template", "Support", "Log", "Method", "Time", "Max Memory"), sep=" ")
logs = sorted(cf_df['Log'].unique())

latex_rows = []
for log in logs:
	latex_row = []
	for method in ['asp_native', 'd4py', 'automata', 'ltlf_base']:
		to_plot = cf_df[(cf_df['Method'] == method) & (cf_df['Log'] == log)]
		latex_row.append(to_plot['Max Memory'].max())


	for method in ['asp_native', 'd4py', 'automata', 'ltlf_base']:
		to_plot = qc_df[(qc_df['Method'] == method) & (qc_df['Log'] == log)]
		latex_row.append(to_plot['Max Memory'].max())

	latex_rows.append((log, latex_row))

for log, times in latex_rows:
	times = ["{:.3f}".format(x) for x in times]
	print(' & '.join([log] + times) + '\\\\')
