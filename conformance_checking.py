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
    p.add_argument('model', type=str, help='A DECLARE model in decl format.')
    p.add_argument('-m', '--method', type=str, default='asp_native')

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

    return args


def d4py_conformance_checking(args):
    from Declare4Py.ProcessModels.DeclareModel import DeclareModel
    from Declare4Py.ProcessMiningTasks.Discovery.DeclareMiner import DeclareMiner
    from Declare4Py.ProcessMiningTasks.ConformanceChecking.MPDeclareAnalyzer import MPDeclareAnalyzer
    from Declare4Py.D4PyEventLog import D4PyEventLog
    event_log = D4PyEventLog()
    event_log.parse_xes_log(args.log)

    decl_strings = Path(args.model).read_text()
    model = DeclareModel()
    model.parse_from_string(
        '\n'.join(c+' |\n' for c in decl_strings.split('\n')))

    checker = MPDeclareAnalyzer(
        log=event_log, declare_model=model, consider_vacuity=True)
    ans = checker.run()

    return dump_checker_as_tuples(ans.get_metric('state'))

def clingo_conformance_checking(args):
    ctl = clingo.Control()
    ctl.add("base", [], reify_decl_model(args.model))
    ctl.add("base", [], xes2lp(args.log))
    ctl.add("base", [], "#show. #show (C,TID): sat(_,C,TID).")

    for lp_file in Path(args.method).glob('*.lp'):
        ctl.load(lp_file.as_posix())

    ctl.ground([("base", [])])
    ans = ctl.solve(yield_=True)

    return ["({},{})".format(*c.arguments) for c in ans.model().symbols(shown=True)]


if __name__ == '__main__':
    args = parse_args()
    if args.method == 'd4py':
        checkers = d4py_conformance_checking(args)
    else:
        checkers = clingo_conformance_checking(args)

    for c in checkers:
        print(c)
