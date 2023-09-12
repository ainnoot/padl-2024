#script(python)

from ltlf2dfa.ltlf import *
from ltlf2dfa.parser.ltlf import LTLfParser
import re
import clingo
parser = LTLfParser()

declare_templates = {
	"Existence": "F(arg_0)",
	"Absence": "~F(arg_0)",
	"Init": "arg_0",
	"Last": "last",
	"Choice": "F(arg_0) | F(arg_1)",
	"ExclusiveChoice": "(F(arg_0) | F(arg_1)) & ~(F(arg_0) & F(arg_1))",
	"RespondedExistence": "F(arg_0) -> F(arg_1)",
	"CoExistence": "(F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))",
	"Response": "G(arg_0 -> F(arg_1))",
	"AlternateResponse": "G(arg_0 -> X(~arg_0 U arg_1))",
	"ChainResponse": "G(arg_0 -> X(arg_1))",
	"NotCoExistence": "(F(arg_0) -> ~F(arg_1)) & (F(arg_1) -> ~F(arg_0))",
	"NotSuccession": "G(arg_0 -> ~F(arg_1))",
	"NotChainSuccession": "G(arg_0 -> ~X(arg_1))",
	"Precedence": "~arg_1 R arg_0",
	"AlternatePrecedence": "(~arg_1 R arg_0) & G(arg_1 -> (~arg_1 R arg_0))",
	"ChainPrecedence": "G(X(arg_1) -> arg_0)",
	"Succession": "G(arg_0 -> F(arg_1)) & (~arg_1 R arg_0)",
	"AlternateSuccession": "G(arg_0 -> X(~arg_0 U arg_1)) & (~arg_1 R arg_0) & G(arg_1 -> (~arg_1 R arg_0))",
	"ChainSuccession": "G(arg_0 -> X(arg_1)) & G(X(arg_0) -> arg_1)"
}

def term_representation_of(node, parameters):
	if isinstance(node, LTLfLast):
		return "(last,)"

	if isinstance(node, LTLfTrue):
		return "(true,)"

	if isinstance(node, LTLfFalse):
		return "(false,)"

	if isinstance(node, LTLfRelease):
		return "(release,{},{})".format(
			term_representation_of(node.formulas[0], parameters),
			term_representation_of(node.formulas[1], parameters)
		)

	if isinstance(node, LTLfAtomic):
		#TODO: validate arg
		arg_no = int(node.s.strip().split('_')[1])
		return "(atom,\"{}\")".format(parameters[arg_no])

	elif isinstance(node, LTLfAlways):
		return "(always,{})".format(term_representation_of(node.f, parameters))

	elif isinstance(node, LTLfAnd):
		return "(conjunction,{},{})".format(
			term_representation_of(node.formulas[0], parameters),
			term_representation_of(node.formulas[1], parameters)
		)

	elif isinstance(node, LTLfEquivalence):
		return "(equals,{},{})".format(
			term_representation_of(node.formulas[0], parameters),
			term_representation_of(node.formulas[1], parameters)
		)

	elif isinstance(node, LTLfEventually):
		return "(eventually,{})".format(term_representation_of(node.f, parameters))

	elif isinstance(node, LTLfImplies):
		return "(implies,{},{})".format(
			term_representation_of(node.formulas[0], parameters),
			term_representation_of(node.formulas[1], parameters)
		)

	elif isinstance(node, LTLfNext):
		return "(next,{})".format(term_representation_of(node.f, parameters))

	elif isinstance(node, LTLfNot):
		return "(negate,{})".format(term_representation_of(node.f, parameters))

	elif isinstance(node, LTLfOr):
		return "(disjunction,{},{})".format(
			term_representation_of(node.formulas[0], parameters),
			term_representation_of(node.formulas[1], parameters)
		)

	elif isinstance(node, LTLfUntil):
		return "(until,{},{})".format(
			term_representation_of(node.formulas[0], parameters),
			term_representation_of(node.formulas[1], parameters)
		)

def parse(f, *args):
	parameters = {
		param_id: value.string for param_id, value in enumerate(args)
	}
	string_term = term_representation_of(parser(f.string), parameters)
	return clingo.parse_term(string_term)

def parse_declare(f, *args):
	formula_str = declare_templates[f.string]
	parameters = {
		param_id: value.string for param_id, value in enumerate(args)
	}
	string_term = term_representation_of(parser(formula_str), parameters)
	return clingo.parse_term(string_term)
#end.
