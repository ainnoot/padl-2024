ACTIVITIES = """
activity a_0
activity a_1
activity a_2
activity a_3
activity a_4
activity a_5
activity a_6
activity a_7
activity a_8
activity a_9
"""

CONSTRAINTS = [
	"Response[a_0, a_1] | | |",
	"Alternate Response[a_0, a_1] | | |",
	"Chain Response[a_0, a_1] | | |",
	"Precedence[a_0, a_1] | | |",
	"Alternate Precedence[a_0, a_1] | | |",
	"Chain Precedence[a_0, a_1] | | |",
	"Succession[a_0, a_1] | | |",
	"Alternate Succession[a_0, a_1]| | |",
	"Chain Succession[a_0, a_1]| | |"
]

import sys
import os

if len(sys.argv) != 2:
	print("Usage: {} [output_path]".format(__file__))
	sys.exit(1)

PATH = sys.argv[1]

for constraint in CONSTRAINTS:
	model_str = ACTIVITIES + "\n" + constraint + "\n"
	constraint_name, _ = constraint.split('[', 1)
	model_name = "_".join(constraint_name.lower().split(' ')) + '.decl'
	decl_path = os.path.join(PATH, model_name)
	with open(decl_path, 'w') as f:
		f.write(model_str)

	model_lp_name = "_".join(constraint_name.lower().split(' ')) + '.lp'
	lp_path = os.path.join(PATH, model_lp_name)
	with open(lp_path, 'w') as f:
		f.write("constraint(0, \"{}\").\n".format(constraint_name))
		f.write("bind(0, arg_0, \"a_0\").\n")
		f.write("bind(0, arg_1, \"a_1\").\n")
