from pathlib import Path 
import sys
import clingo

BASE_DIR = Path(__file__).parent

DECLARE_MODELS_PATH = BASE_DIR / 'declare_constraints'

FUZZ_PROGRAM = """
#const t=12.
time(0..t-1).
activity("*").
activity(A) :- bind(_,_,A).
1 { trace(1,T,A): activity(A) } 1 :- time(T).

% count = 2 -> both SAT
% count = 0 -> both UNSAT
% count = 1 -> counterexample
:- #count{M: sat(M,C,_)} != 1, constraint(C, _).

#show.
#show sat/3.
"""

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

class Context:
	@staticmethod
	def parse_bindings(bindings):
		bindings_dict = {}
		for binding in bindings:
			assert len(binding.arguments) == 2, "A valid binding should be of the form: (arg_i, val)"
			arg, val = binding.arguments
			bindings_dict[arg.name] = val.string
		return bindings_dict

	@staticmethod
	def recursively_substitute(formula, bindings):
		if formula.arguments[0].name == 'atom':
			arg = formula.arguments[1].name
			return clingo.Function('', [clingo.Function('atom'), clingo.String(bindings[arg])])
		elif len(formula.arguments) == 2:
			term = Context.recursively_substitute(formula.arguments[1], bindings)
			return clingo.Function('', [clingo.Function(formula.arguments[0].name), term])
		elif len(formula.arguments) == 3:
			lhs, rhs = [Context.recursively_substitute(c, bindings) for c in formula.arguments[1:]]
			return clingo.Function('', [clingo.Function(formula.arguments[0].name), lhs, rhs])
		else:
			raise RuntimeError("Unknown LTLf node:", formula)

	@staticmethod
	def substitute(base_formula, bindings):
		bindings_dict = Context.parse_bindings(bindings.arguments)
		return Context.recursively_substitute(base_formula, bindings_dict)

def print_witness(model):
	trace = []
	for symbol in model.symbols(atoms=True):
		if symbol.name != 'trace':
			continue
		trace.append((symbol.arguments[1].number, symbol.arguments[2].string))
	trace.sort(key=lambda x: x[0])
	trace_string = ''.join(x[1] for x in trace)

	print(bcolors.FAIL + "\nFound a problem:", trace_string)
	print(bcolors.FAIL + "Projected model:", ' '.join(str(x) for x in model.symbols(shown=True)))

def constraint_name(path):
	return path.name.split('.')[0]

if __name__ == '__main__':
	enc_1, enc_2 = sys.argv[1:]

	for declare_constraint in Path(DECLARE_MODELS_PATH).glob("*.lp"):
		print(bcolors.HEADER + "% Constraint: " + declare_constraint.stem + bcolors.ENDC, end='... ')
		ctl = clingo.Control()
		ctl.add("base", [], FUZZ_PROGRAM)
		ctl.load(declare_constraint.as_posix())
		for part in Path(enc_1).glob("*.lp"):
			ctl.load(part.as_posix())

		for part in Path(enc_2).glob("*.lp"):
			ctl.load(part.as_posix())

		ctl.ground([("base",[])], context=Context())
		ans = ctl.solve(on_model=print_witness)

		color = bcolors.OKGREEN if ans.unsatisfiable else bcolors.FAIL

		if ans.unsatisfiable:
			print(color + "OK!" + bcolors.ENDC)

		else:
			print(color + "WRONG!" + bcolors.ENDC)
