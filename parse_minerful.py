from dataclasses import dataclass
from typing import List
import json 

def inverse_cc(q):
	return ''.join(map(lambda x: x if x.islower() else " "+x, q)).strip()

minerful_to_aaai = {
"AtLeast1": 'Existence',
"AtMost1": 'Absence 2',
"Choice": 'Choice',
"ExclusiveChoice": 'Exclusive Choice',
"RespondedExistence": 'Responded Existence',
"CoExistence": 'Coexistence',
"Response": 'Response',
"Precedence": 'Precedence',
"Succession": 'Succession',
"AlternatePrecedence": 'Alternate Precedence',
"AlternateResponse": 'Alternate Response',
"AlternateSuccession": 'Alternate Succession',
"ChainPrecedence": 'Chain Precedence',
"ChainResponse": 'Chain Response',
"ChainSuccession": 'Chain Succession',
"NotCoExistence": 'Not Coexistence',
"NotSuccession": 'Neg Succession',
"NotChainSuccession": 'Neg Chain Succession'
}

@dataclass(frozen=True)
class Constraint:
	template: str
	parameters: List[str]

	@staticmethod
	def of(dict_constraint):
		return Constraint(
			dict_constraint['template'],
			[x[0] for x in dict_constraint['parameters']]
		)

	def reify(self, cid, sexpr=False):
		prg = []
		if not sexpr:
			prg.append("constraint({}, \"{}\").".format(cid, minerful_to_aaai[self.template]))
			for arg_id, p in enumerate(self.parameters):
				prg.append("bind({}, arg_{}, \"{}\").".format(cid, arg_id, p))
		else:
			bindings = ["(arg_{}, \"{}\")".format(arg_id, p) for arg_id, p in enumerate(self.parameters)]
			bindings = "(" + ",".join(bindings) + ",)"
			prg.append("constraint({}, \"{}\", {}).".format(cid, minerful_to_aaai[self.template], bindings))

		return '\n'.join(prg)

def reify_model(dict_model, sexpr=False):
	prg = []
	cid = 0
	for constraint in dict_model['constraints']:
		if constraint['template'] not in minerful_to_aaai: continue
		prg.append(Constraint.of(constraint).reify(cid, sexpr=sexpr))
		cid += 1

	return "\n\n".join(prg)

if __name__ == '__main__':
	import sys
	if len(sys.argv) > 3:
		print("Usage: {} [MINERful JSON output] [--sexpr]".format(__file__))
		sys.exit(1)

	with open(sys.argv[1], 'r') as f:
		data = json.load(f)
		print(reify_model(data, sexpr='--sexpr' in sys.argv[1:]))

