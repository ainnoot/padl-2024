import numpy as np 
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import sys

cf_df = pd.read_csv(sys.argv[1], names=("Method", "Log", "Model", "Time", "Max Memory"), sep=" ")
for method in ['d4py', 'automata', 'asp_native', 'ltlf_base']:
	to_plot = cf_df[cf_df['Method'] == method].sort_values('Time', ascending=True)
	to_plot['Cumulative Sum'] = to_plot['Time'].cumsum()
	print(to_plot.head(5))

	filepath = 'cf_{}.data'.format(method)
	with open(filepath, 'w+') as f:
		for idx, (_, row) in enumerate(to_plot.iterrows()):
			print(idx, row['Cumulative Sum'], file=f)
del cf_df

qc_df = pd.read_csv(sys.argv[2], names=("Template", "Support", "Log", "Method", "Time", "Max Memory"), sep=" ")
for method in ['d4py', 'automata', 'asp_native', 'ltlf_base']:
	to_plot = qc_df[qc_df['Method'] == method].sort_values('Time', ascending=True)
	to_plot['Cumulative Sum'] = to_plot['Time'].cumsum()
	print(to_plot.head(5))

	filepath = 'qc_{}.data'.format(method)
	with open(filepath, 'w+') as f:
		for idx, (_, row) in enumerate(to_plot.iterrows()):
			print(idx, row['Cumulative Sum'], file=f)
