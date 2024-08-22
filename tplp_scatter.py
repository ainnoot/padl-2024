import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import sys
import matplotlib
matplotlib.use("pgf")
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

### TIME SCATTER
MAX_TIME_VALUE = df[['asp_real', 'd4py_real']].values.max()

g = sns.scatterplot(df, x='asp_real', y='d4py_real', size='length', hue='constraint', legend='auto', marker='o', alpha=0.8)

plt.axline(xy1=(10,10), slope=1, color='red', alpha=0.5)
g.set_ylabel("D4Py runtime (s)")
g.set_xlabel("ASP runtime (s)")
g.set_ylim(0,MAX_TIME_VALUE + 5)
g.set_xlim(0,MAX_TIME_VALUE + 5)

sns.move_legend(g, "upper left", bbox_to_anchor=(1, 1), frameon=False)

plt.savefig('scatters.pdf', dpi=1000, transparent=True, bbox_inches='tight')
