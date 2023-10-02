#! ./venv/bin/python3

import clingo
from xes2lp import xes2lp
from parse_decl import reify_decl_model
from argparse import ArgumentParser
import sys
from pathlib import Path
import sys
from dump_d4py_to_lp import dump_checker_as_tuples


def parse_args():
    p = ArgumentParser()
    p.add_argument('log', type=str, help='An event log in XES format.')
    p.add_argument('template', type=str, help='A DECLARE template.')
    p.add_argument('-m', '--method', type=str, default='asp_native')
    p.add_argument('-s', '--min-support', type=float, default=0.8)
    p.add_argument('-o', '--output', type=str)

    methods = [
        'automata',
        'ltlf_base',
        'ltlf_xnf',
        'asp_native',
        'd4py'
    ]

    args = p.parse_args()
    if args.method not in methods:
        raise RuntimeError("Unknown encoding: {}".format(p.method))
        sys.exit(1)

    print(args)
    return args


def d4py_query_checking(args):
    from Declare4Py.ProcessModels.DeclareModel import DeclareModel
    from Declare4Py.ProcessMiningTasks.QueryChecking.DeclareQueryChecker import DeclareQueryChecker
    from Declare4Py.D4PyEventLog import D4PyEventLog

    event_log = D4PyEventLog()
    event_log.parse_xes_log(args.log)

    query_checker = DeclareQueryChecker(
        log=event_log, consider_vacuity=True, template=args.template, min_support=args.min_support)

    ans = query_checker.run()
    q = ans.filter_query_checking(queries=['activation', 'target'])
    return ["(\"{}\", \"{}\")".format(row['activation'], row['target']) for idx, row in q.iterrows()]


class Collector:
    def __init__(self):
        self.pairs = []

    def __call__(self, model):
        for sym in model.symbols(shown=True):
            self.pairs.append(sym)


def clingo_query_checking(args):
    log, length = xes2lp(args.log)

    ctl = clingo.Control(["--models=0"])
    QUERY_CHECKING = """
	constraint(0, \"{template}\").
	activity(A) :- trace(_,_,A).

	1 {{ bind(0, arg_0, A): activity(A) }} 1.
	1 {{ bind(0, arg_1, A): activity(A) }} 1.
	:- bind(0, Arg, A), bind(0, Arg', A), Arg < Arg'.

    :- #count{{X: trace(X,_,_), constraint(C,_), not sat(_,C,X)}} >= {min_support}.
	""".format(template=args.template, min_support=int((1 - args.min_support) * length) + 1)

    ctl.add("base", [], log)
    ctl.add("base", [], QUERY_CHECKING)
    ctl.add("base", [], "#show. #show (Arg1, Arg2): bind(0, arg_0, Arg1), bind(0, arg_1, Arg2).")

    for lp_file in Path(args.method).glob('*.lp'):
        ctl.load(lp_file.as_posix())

    ctl.ground([("base", [])])
    collector = Collector()
    ans = ctl.solve(on_model=collector)

    return ["({}, {})".format(*sym.arguments) for sym in collector.pairs]


if __name__ == '__main__':
    args = parse_args()
    if args.method == 'd4py':
        result = d4py_query_checking(args)
    else:
        result = clingo_query_checking(args)

    with open(args.output, 'w+') as f:
        f.write("Answers: {}\n".format(len(result)))
        for qid, c in enumerate(result, start=1):
            f.write("Query Answer #{}: {}\n".format(qid,c))
