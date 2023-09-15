import sys
from flloat.ltlf import *
from flloat.parser.ltlf import LTLfParser
from pathlib import Path
import re

class IDGenerator:
	def __init__(self, start=0):
		self.next_id = start

	def __call__(self):
		value = self.next_id
		self.next_id += 1
		return value

def syntax_tree_of(f):
	id_pool = IDGenerator()

	def node_to_atom(node):
		if isinstance(node, LTLfLast):
			return "last({})"

		if isinstance(node, LTLfTrue):
			return "true({})"

		if isinstance(node, LTLfFalse):
			return "false({})"

		if isinstance(node, LTLfRelease):
			return "relase({},{},{})"

		if isinstance(node, LTLfAtomic):
			return "atom({},{})"

		elif isinstance(node, LTLfAlways):
			return "always({},{})"

		elif isinstance(node, LTLfAnd):
			return "conjunction({},{},{})"

		elif isinstance(node, LTLfEquivalence):
			return "equals({},{},{})"

		elif isinstance(node, LTLfEventually):
			return "eventually({},{})"

		elif isinstance(node, LTLfImplies):
			return "implies({},{},{})"

		elif isinstance(node, LTLfNext):
			return "next({},{})"

		elif isinstance(node, LTLfNot):
			return "negate({},{})"

		elif isinstance(node, LTLfOr):
			return "disjunction({},{},{})"

		elif isinstance(node, LTLfUntil):
			return "until({},{},{})"

		elif isinstance(node, LTLfWeakNext):
			return "weak_next({},{},{})"

	prg = []
	queue = [(f,id_pool())]
	var_pattern = r'arg_(\d+)'

	while len(queue) > 0:
		top, node_id = queue.pop(0)

		if isinstance(top, LTLfUnaryOperator):
			children_id = id_pool()
			queue.append((top.f, children_id))
			prg.append(node_to_atom(top).format(node_id, children_id))

		elif isinstance(top, LTLfBinaryOperator):
			lhs_id = id_pool()
			rhs_id = id_pool()
			queue.append((top.formulas[0], lhs_id))
			queue.append((top.formulas[1], rhs_id))
			prg.append(node_to_atom(top).format(node_id, lhs_id, rhs_id))

		elif isinstance(top, LTLfAtomic):
			assert re.match(var_pattern, top.s) or top.s in ['false', 'true', 'last']
			prg.append(node_to_atom(top).format(node_id, top.s))

		elif isinstance(top, LTLfLast):
			prg.append(node_to_atom(top).format(node_id))

	return prg

def compile_patterns(filename):
	parser = LTLfParser()
	patterns_prg = []

	lines = Path(filename).read_text().split('\n')
	for line in lines:
		line = line.strip()
		if len(line) == 0 or line.startswith("%"):
			continue

		name, formula = line.split(':')
		prg = syntax_tree_of(parser(formula))

		pattern_facts = ['% {} -- {}'.format(name.strip(), formula.strip())] + ["template(\"{}\", {}).".format(name, x) for x in prg]
		patterns_prg.append('\n'.join(pattern_facts) + "\n")

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
