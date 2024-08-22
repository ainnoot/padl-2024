import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import sys
import matplotlib
#matplotlib.use("pgf")
from matplotlib import pyplot as plt

matplotlib.rcParams.update({
    "pgf.texsystem": "pdflatex",
    'font.family': 'serif',
	'font.weight': 'bold',
    'text.usetex': True,
    'pgf.rcfonts': False,
})

if len(sys.argv) != 2:
	print("Usage: {} results.csv".format(__file__))
	sys.exit(1)

df = pd.read_csv(sys.argv[1])
f, axes = plt.subplots(1, 2)

time_scatter_ax = axes[0]
memo_scatter_ax = axes[1]

### TIME SCATTER
MAX_TIME_VALUE = df[['asp_real', 'd4py_real']].values.max()

sns.scatterplot(df, x='asp_real', y='d4py_real', size='length', hue='constraint', legend='auto', marker='o', ax=time_scatter_ax)

time_scatter_ax.axline(xy1=(10,10), slope=1, color='red', alpha=0.5)
time_scatter_ax.set_ylabel("D4Py runtime (s)")
time_scatter_ax.set_xlabel("ASP runtime (s)")
time_scatter_ax.set_ylim(0,MAX_TIME_VALUE + 5)
time_scatter_ax.set_xlim(0,MAX_TIME_VALUE + 5)

### MEMO SCATTER
MAX_MEMO_VALUE = df[['asp_memo', 'd4py_memo']].values.max()

sns.scatterplot(df, x='asp_memo', y='d4py_memo', size='length', hue='constraint', legend='auto', marker='o', ax=memo_scatter_ax)

memo_scatter_ax.axline(xy1=(10,10), slope=1, color='red', alpha=0.5)
memo_scatter_ax.set_ylabel("D4Py Peak Memory (MB)")
memo_scatter_ax.set_xlabel("ASP Peak Memory (MB)")
memo_scatter_ax.set_ylim(0,MAX_MEMO_VALUE + 5)
memo_scatter_ax.set_xlim(0,MAX_MEMO_VALUE + 5)

plt.show()
