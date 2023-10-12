import numpy as np 
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import sys


plt.rcParams.update({'font.size': 16})

plt.figure(figsize=(12, 6))
plt.yscale('log')
df = pd.read_csv(sys.argv[1], names=("Template", "Support", "Log", "Method", "Time", "Max Memory"), sep=" ")

vlines = []

for method in ['d4py', 'automata', 'asp_native', 'ltlf_base']:
	to_plot = df[df['Method'] == method].sort_values('Time', ascending=True)
	to_plot['Cumulative Sum'] = to_plot['Time'].cumsum()
	vlines.append(to_plot['Cumulative Sum'].max())

	print(to_plot.head(10))
	sns.lineplot(x = range(len(to_plot)), y='Cumulative Sum', data=to_plot, marker="o", sort=False, label=method)

for h in vlines:
	plt.axhline(y=h, color='r', linestyle='-', alpha=0.4)

plt.title('Cactus Plot of Cumulative Solving Time Across Different Methods')
plt.xlabel('Query Checking Instances')
plt.ylabel('Cumulative Solving Time (s)')
plt.xticks(rotation=45, ha='right')  # Rotate x-axis labels for better readability
plt.ylim(1, max(vlines) + 1000)
plt.xlim(0, 273)

print(vlines)
rax = plt.twinx()
rax.set(yscale='log')

rax.set_yticks([x for x in vlines])
rax.set_yticklabels(["{:.3f}s".format(x) for x in vlines])
rax.set_ylim(1, max(vlines) + 1000)

plt.tight_layout()
plt.savefig('plots/qc_cactus.svg')

