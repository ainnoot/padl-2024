#! ./venv/bin/python3

import clingo
from xes2lp import xes2lp
from parse_decl import reify_decl_model
from argparse import ArgumentParser
import sys
from pathlib import Path
import sys


def parse_args():
    p = ArgumentParser()
    p.add_argument('model', type=str, help='A DECLARE model in decl format.')
    p.add_argument('-m', '--method', type=str, default='asp_native')
    p.add_argument('-l', '--length', type=int, default=15)
    p.add_argument('--max-traces', type=int, default=100)
    p.add_argument('--negative', action='store_true')

    methods = [
        'automata',
        'ltlf_base',
        'ltlf_xnf',
        'asp_native',
    ]

    args = p.parse_args()
    if args.method not in methods:
        raise RuntimeError("Unknown encoding: {}".format(p.method))
        sys.exit(1)
    return args


class Collector:
    def __init__(self):
        self.traces = []

    def __call__(self, model):
        trace = []
        for symbol in model.symbols(atoms=True):
            if symbol.name != 'trace':
                continue
            trace.append(
                (symbol.arguments[1].number, symbol.arguments[2].string))
        trace.sort(key=lambda x: x[0])
        trace_string = ', '.join(x[1] for x in trace)
        self.traces.append(trace_string)


def generate_trace_skeletons(decl, method, length, args):
    model = reify_decl_model(decl)

    LOG_GENERATION = """
	activity(A) :- bind(_,_,A).
	activity("*").
	#const length=15.
	1 { trace(1,T,A): activity(A) } 1 :- T=0..length-1.
	"""
    POS_OR_NEG = ":- constraint(C,_), not sat(_,C,1)." if not args.negative else "rej :- constraint(C,_), not sat(_,C,1). :- not rej."

    ctl = clingo.Control(["--models={}".format(args.max_traces), "-c length={}".format(length)])
    ctl.add("base", [], model)
    ctl.add("base", [], LOG_GENERATION)
    ctl.add("base", [], POS_OR_NEG)
    ctl.add("base", [], "#show. #show trace/3.")

    for lp_file in Path(method).glob('*.lp'):
        ctl.load(lp_file.as_posix())

    ctl.ground([("base", [])])
    trace_collector = Collector()
    ans = ctl.solve(on_model=trace_collector)

    return trace_collector.traces


if __name__ == '__main__':
    args = parse_args()
    traces = generate_trace_skeletons(args.model, args.method, args.length, args)
    for t in traces:
        print(t)
