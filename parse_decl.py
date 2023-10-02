from dataclasses import dataclass
from typing import List
from pathlib import Path


def inverse_cc(q):
	return ''.join(map(lambda x: x if x.islower() else " "+x, q)).strip()

@dataclass(frozen=True)
class Constraint:
	template: str
	parameters: List[str]

	@staticmethod
	def of(decl_string):
		# Choice[ER Sepsis Triage, ER Registration] | |
		template_name, garbage = decl_string.split('[', 1)
		parameters_list, _ = garbage.split(']',1)
		parameters = [a.strip() for a in parameters_list.split(',')]

		return Constraint(
			template_name, # TODO: d4py -> aaai 
			parameters
		)

	def reify(self, cid):
		prg = []
		prg.append("constraint({}, \"{}\").".format(cid, self.template))
		for arg_id, p in enumerate(self.parameters):
			prg.append("bind({}, arg_{}, \"{}\").".format(cid, arg_id, p))
		return '\n'.join(prg)

def reify_decl_model(decl_model_path, sexpr=False):
	decl_model = Path(decl_model_path).read_text()
	prg = []
	cid = 0
	for line in decl_model.split('\n'):
		line = line.strip()
		if line.startswith('activity') or len(line) == 0: continue
		prg.append("% {}".format(line))
		prg.append(Constraint.of(line).reify(cid))
		cid += 1
	return "\n\n".join(prg)

if __name__ == '__main__':
	import sys
	if len(sys.argv) > 3:
		print("Usage: {} [Declare model]".format(__file__))
		sys.exit(1)

	decl = Path(sys.argv[1]).read_text()
	print(reify_model(decl))



