from dataclasses import dataclass
import sys
from typing import List
import json
from pathlib import Path

@dataclass(frozen=True)
class Constraint:
	template: str
	parameters: List[str]

	@property
	def name(self):
		return "{}({})".format(self.template, ",".join(self.parameters))

	def __reify_flat__(self, cid):
		prg = ["\n% {}".format(self.name)]
		prg.append("constraint({},\"{}\").".format(cid, self.template))
		for arg_no, value in enumerate(self.parameters):
			prg.append("bind({}, arg_{}, \"{}\").".format(cid, arg_no, value))
		return "\n".join(prg)

	def __reify_term__(self, cid):
		prg = ["\n% {}".format(self.name)]
		bindings = []
		for arg_no, value in enumerate(self.parameters):
			bindings.append("(arg_{}, \"{}\")".format(arg_no, value))
		prg.append("constraint({},\"{}\",({})).".format(cid, self.template, ",".join(bindings)))
		return "\n".join(prg)

	def reify(self, cid, term_encoding=False):
		return self.__reify_term__(cid) if term_encoding else self.__reify_flat__(cid)

	@staticmethod
	def from_minerful_json(data):
		return Constraint(data['template'], [p[0] for p in data['parameters']])

	@staticmethod
	def from_decl_string(decl_string):
		# Response[Leucocytes, CRP] | |
		template, data = decl_string.split('[', 1)
		arg_list, _ = data.split(']', 1)
		return Constraint(template.strip(), [a.strip() for a in arg_list.split(',')])

class DeclareModel:
	@property
	def constraints(self):
		return self._constraints

	def reify(self, term_encoding=False):
		prg = []
		for cid, constraint in enumerate(self.constraints):
			prg.append(constraint.reify(cid, term_encoding=term_encoding))
		return "\n".join(prg)

class DeclFlat(DeclareModel):
	def __init__(self, decl_file_path):
		self._constraints = []
		constraints = decl_file_path.read_text().split('\n')
		for c in constraints:
			self.constraints.append(Constraint.from_decl_string(c))

class MinerfulJSON(DeclareModel):
	def __init__(self, minerful_json_file_path):
		minerful_json = json.loads(minerful_json_file_path.read_text())
		constraints = minerful_json['constraints']
		self._constraints = [Constraint.from_minerful_json(c) for c in constraints]

suffix_to_cls = {
	'.json': MinerfulJSON,
	'.decl': DeclFlat
}

if __name__ == '__main__':
	if len(sys.argv) < 2:
		print("Usage: {} [MINERful JSON model | DECL model] [-t]")
		sys.exit(1)

	model_file = Path(sys.argv[1])
	model = suffix_to_cls[model_file.suffix](model_file)

	print(model.reify(term_encoding=('-t' in sys.argv)))
