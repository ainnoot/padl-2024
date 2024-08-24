from random import sample
import sys

if len(sys.argv) != 3:
	print("Usage: [trace length] [interesting events]")
	sys.exit(1)

trace_length = int(sys.argv[1])
num_interesting  = int(sys.argv[2])

for tid in range(100):
	trace = ["*" for _ in range(trace_length)]
	interesting = sample(list(range(trace_length)), num_interesting*2)

	for i in interesting[:num_interesting]:
		trace[i] = "a_0"

	for i in interesting[num_interesting:]:
		trace[i] = "a_1"

	for t, a in enumerate(trace):
		print("trace({},{},\"{}\").".format(tid, t, a))
