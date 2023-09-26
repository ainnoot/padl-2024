import sys
import pm4py


def xes2lp(log_file):
    log = pm4py.read_xes(log_file.absolute().as_posix(), return_legacy_log_object=True)
    prg = []
    for tid, trace in enumerate(log):
        for t, event in enumerate(trace):
            prg.append('trace({},{},\"{}\").'.format(tid, t, event['concept:name']))
    return '\n'.join(prg)
