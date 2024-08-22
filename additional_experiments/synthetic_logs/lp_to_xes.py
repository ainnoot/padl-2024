from pathlib import Path
from typing import List
import sys
import clingo
from collections import defaultdict
import pm4py

def check_args():
	if len(sys.argv) != 2:
		print("Usage: {} glob".format(Path(__file__).name))
		sys.exit(1)

	return sys.argv[1]

def trace_pairs_to_string(trace_pairs):
	# sort by increasing time index
	ls = sorted(trace_pairs, key=lambda x: x[0])
	string = ','.join(x[1] for x in ls)
	return string


def traces_from_lp_file(filename: Path) -> List[str]:
	log = defaultdict(lambda: [])
	# trace_id -> [(1,a), (2,b), ...]

	with filename.open('r') as f:
		lines = f.readlines()
		for line in lines:
			line = line.strip()
			if not line:
				return log

			assert line[-1] == '.', "I expected one fact per line, missing '.'"
			atom = clingo.parse_term(line[:-1])

			assert atom.name == 'trace' and len(atom.arguments) == 3, f"Fact does not match trace/3: {str(atom)}"

			tid = atom.arguments[0].number
			t = atom.arguments[1].number
			a = atom.arguments[2].string

			log[tid].append((t,a))

	xes_log = []
	for tid, pairs in log.items():
		xes_log.append(trace_pairs_to_string(pairs))

	return xes_log

if __name__ == '__main__':
	glob_expression = check_args()

	for log_facts in Path(__file__).parent.glob(glob_expression):
		print("Found log facts:", log_facts.name)

		parsed_traces = traces_from_lp_file(log_facts)
		event_log = pm4py.parse_event_log_string(parsed_traces)

		target = log_facts.with_suffix('.xes')
		print("Writing to:", target)

		pm4py.write_xes(event_log, target)
