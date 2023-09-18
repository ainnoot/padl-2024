from dataclasses import dataclass
import sys
from typing import List
import json

@dataclass(frozen=True)
class Constraint:
	template: str
	parameters: List[str]
	support: float
	confidence: float
	interestFactor: float

	@property
	def name(self):
		return "{}({})".format(self.template, ",".join(x[0] for x in self.parameters))

@dataclass
class MinerfulModel:
	name: str
	tasks: List[str]
	constraints: List[Constraint]

	def __init__(self, name, tasks, constraints):
		self.name = name
		self.tasks = tasks

		def clean_args(data):
			data['parameters'] = [p[0] for p in data['parameters']]
			return data

		self.constraints = [Constraint(**clean_args(args)) for args in constraints]

	def reify(self, activities=True, term_encoding=False):
		prg = []
		if activities:
			for task in self.tasks:
				prg.append("activity(\"{}\").".format(task))

		if not term_encoding:
			for cid, constraint in enumerate(self.constraints):
				prg.append("\n% {}".format(constraint.name))
				prg.append("constraint({},\"{}\").".format(cid, constraint.template))
				for arg_no, value in enumerate(constraint.parameters):
					prg.append("bind({}, arg_{}, \"{}\").".format(cid, arg_no, value))
			return "\n".join(prg)

		else:
			for cid, constraint in enumerate(self.constraints):
				prg.append("\n% {}".format(constraint.name))
				bindings = []
				for arg_no, value in enumerate(constraint.parameters):
					bindings.append("(arg_{}, \"{}\")".format(arg_no, value))
				prg.append("constraint({},\"{}\",({})).".format(cid, constraint.template, ",".join(bindings)))
			return "\n".join(prg)

if __name__ == '__main__':
	if len(sys.argv) < 2:
		print("Usage: {} [MINERful JSON model] [-a] [-t]")
		sys.exit(1)

	with open(sys.argv[1], 'r') as model_json:
		model = MinerfulModel(**json.load(model_json))

	print(model.reify(activities=('-a' in sys.argv), term_encoding=('-t' in sys.argv)))
