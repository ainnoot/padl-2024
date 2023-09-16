import sys
from custom_ltlf_parser import LTLfParser
from pythomata import SimpleDFA
from pathlib import Path

# https://raw.githubusercontent.com/fracchiariello/LTLp2DFA/main/LTLp2DFA.py
# TODO: Import, rather than copy paste

def symbolic_to_singleton(symbolic_dfa, letters):
    states = symbolic_dfa.states
    initial_state = symbolic_dfa.initial_state
    accepting_states = symbolic_dfa.accepting_states

    transition_function = {}
    for s in states:
        transitions_of_s = {}
        for _, formula, s_1  in symbolic_dfa.get_transitions_from(s):
            for letter in letters:
                interpretation = {l:0 for l in letters}
                interpretation[letter] = 1
                if formula.subs(interpretation):
                    transitions_of_s[letter] = s_1
        transition_function[s] = transitions_of_s

    singleton_dfa = SimpleDFA(states, letters, initial_state, accepting_states, transition_function)
    singleton_dfa = singleton_dfa
    singleton_dfa = singleton_dfa.complete()
    return singleton_dfa

def automaton_of(f):
	symbolic_dfa = f.to_automaton()
	alphabet = f.find_labels()
	alphabet.add("__skip__")
	dfa = symbolic_to_singleton(symbolic_dfa, alphabet)

	delta = []
	for s_0, outgoing_edges in dfa.transition_function.items():
		for symbol, s_1 in outgoing_edges.items():
			delta.append((s_0, symbol, s_1))

	accepting = list(dfa.accepting_states)
	return delta, accepting, dfa.initial_state

def compile_patterns(filename):
	parser = LTLfParser()
	patterns_prg = []

	lines = Path(filename).read_text().split('\n')
	for line in lines:
		line = line.strip()
		if len(line) == 0 or line.startswith("%"):
			continue

		name, formula = line.split(':')
		delta, accepting, initial = automaton_of(parser(formula))

		pattern_facts = ['% {} -- {}'.format(name.strip(), formula.strip())]
		for s_0, symbol, s_1 in delta:
			pattern_facts.append("template(\"{}\",{},{},{}).".format(name, s_0, symbol, s_1))
		for s in accepting:
			pattern_facts.append("accepting(\"{}\",{}).".format(name, s))		
		pattern_facts.append("initial(\"{}\",{}).".format(name, initial))
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

