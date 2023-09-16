import sys
from flloat.ltlf import *
from custom_ltlf_parser import LTLfParser
from pathlib import Path
import re

var_pattern = r'arg_(\d+)'

def term_representation_of(node):
	if isinstance(node, LTLfLast):
		return "(last,)"

	if isinstance(node, LTLfTrue):
		return "(true,)"

	if isinstance(node, LTLfFalse):
		return "(false,)"

	# Recall (a W b) gets compiled into (b R (a | b)) !
	if isinstance(node, LTLfRelease):
		return "(release,{},{})".format(
			term_representation_of(node.formulas[0]),
			term_representation_of(node.formulas[1])
		)

	if isinstance(node, LTLfAtomic):
		assert re.match(var_pattern, node.s) or node.s in ['false', 'true', 'last']
		return "(atom,{})".format(node.s)

	elif isinstance(node, LTLfAlways):
		return "(always,{})".format(term_representation_of(node.f))

	elif isinstance(node, LTLfAnd):
		return "(conjunction,{},{})".format(
			term_representation_of(node.formulas[0]),
			term_representation_of(node.formulas[1])
		)

	elif isinstance(node, LTLfEquivalence):
		return "(equals,{},{})".format(
			term_representation_of(node.formulas[0]),
			term_representation_of(node.formulas[1])
		)

	elif isinstance(node, LTLfEventually):
		return "(eventually,{})".format(term_representation_of(node.f))

	elif isinstance(node, LTLfImplies):
		return "(implies,{},{})".format(
			term_representation_of(node.formulas[0]),
			term_representation_of(node.formulas[1])
		)

	elif isinstance(node, LTLfNext):
		return "(next,{})".format(term_representation_of(node.f))

	elif isinstance(node, LTLfNot):
		return "(negate,{})".format(term_representation_of(node.f))

	elif isinstance(node, LTLfOr):
		return "(disjunction,{},{})".format(
			term_representation_of(node.formulas[0]),
			term_representation_of(node.formulas[1])
		)

	elif isinstance(node, LTLfUntil):
		return "(until,{},{})".format(
			term_representation_of(node.formulas[0]),
			term_representation_of(node.formulas[1])
		)


def compile_patterns(filename):
	parser = LTLfParser()
	patterns_prg = []

	lines = Path(filename).read_text().split('\n')
	for line in lines:
		line = line.strip()
		if len(line) == 0 or line.startswith("%"):
			continue

		name, formula = line.split(':')
		term_encoding = term_representation_of(parser(formula))

		patterns_prg.append('% {} -- {}\ntemplate(\"{}\", {}).\n'.format(name, formula, name, term_encoding))

	return '\n'.join(patterns_prg)

if __name__ == '__main__':
	if len(sys.argv) != 2:
		print("Usage: {} [path to LTLf templates' definitions]".format(Path(__file__).stem))
		sys.exit(1)

	if not Path(sys.argv[1]).exists():
		print("File does not exist: {}".format(sys.argv[1]))
		sys.exit(1)

	filename = sys.argv[1]
	prg = compile_patterns(filename)
	print(prg)
