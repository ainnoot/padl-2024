#script(python)
import clingo
def parse_bindings(bindings):
	bindings_dict = {}
	for binding in bindings:
		assert len(binding.arguments) == 2, "A valid binding should be of the form: (arg_i, val)"
		arg, val = binding.arguments
		bindings_dict[arg.name] = val.string
	return bindings_dict

def recursively_substitute(formula, bindings):
	if formula.arguments[0].name == 'atom':
		arg = formula.arguments[1].name
		return clingo.Function('', [clingo.Function('atom'), clingo.String(bindings[arg])])
	elif len(formula.arguments) == 2:
		term = recursively_substitute(formula.arguments[1], bindings)
		return clingo.Function('', [clingo.Function(formula.arguments[0].name), term])
	elif len(formula.arguments) == 3:
		lhs, rhs = [recursively_substitute(c, bindings) for c in formula.arguments[1:]]
		return clingo.Function('', [clingo.Function(formula.arguments[0].name), lhs, rhs])

def substitute(base_formula, bindings):
	bindings_dict = parse_bindings(bindings.arguments)
	return recursively_substitute(base_formula, bindings_dict)
#end.
