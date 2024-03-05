import sys
import json

with open(sys.argv[1], 'r') as f:
	data = json.load(f)

table = dict()
constraints = [
	'response', 
	'alternate_response',
	'chain_response',
	'precedence', 
	'alternate_precedence', 
	'chain_precedence'
]

lenghts = [50, 100, 250, 500]

methods = ['asp_native', 'automata']

for c in constraints:
	table[c] = dict()
	for sz in lenghts:
		table[c][sz] = dict()
		for m in methods:
			table[c][sz][m] = None

def parse_constraint_and_size(measure):
	log = measure['log']
	log_file = log.split('/')[1]
	log_name = log_file.split('.')[0]
	tokens = log_name.split('_')
	template_name, sz = tokens[:-1], tokens[-1]
	template_name = '_'.join(template_name)
	sz = int(sz)
	return template_name, sz

for measure in data:
	t = measure['execution_time']
	m = measure['memory_peak']
	method = measure['method']
	template_name, sz = parse_constraint_and_size(measure)
	print("Parsed:", template_name, sz, method, t, m)

	table[template_name][sz][method] = (t, m)

def print_block(table, methods, constraints, lenghts):
	for sz in lenghts:
		row = []
		row.append(str(sz))
		for c in constraints:
			for m in methods:
				t, m = table[c][sz][m]
				row.append("({:.3f} s, {:.3f} MB)".format(t, m))
		print(" & ".join(row) + "\\\\")


print_block(table, ['asp_native', 'automata'], ['response', 'precedence'], [50, 100, 250, 500])
print()
print_block(table, ['asp_native', 'automata'], ['alternate_response', 'alternate_precedence'], [50, 100, 250, 500])
print()
print_block(table, ['asp_native', 'automata'], ['chain_response', 'chain_precedence'], [50, 100, 250, 500])
