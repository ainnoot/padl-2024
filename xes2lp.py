import sys
import pm4py
from pathlib import Path

def xes2lp(log_file):
    log = pm4py.read_xes(Path(log_file).absolute().as_posix(), return_legacy_log_object=True)
    prg = []
    for tid, trace in enumerate(log):
        for t, event in enumerate(trace):
            prg.append('trace({},{},\"{}\").'.format(tid, t, event['concept:name']))
    return '\n'.join(prg), len(log)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: {} [log folder]\n\nWhere [log folder] contains a subfolder `xes` with event logs in XES format. Reified logs are saved in [log folder].".format(__file__))
        sys.exit(1)

    log_folder = sys.argv[1]
    for log in Path(log_folder).glob('xes/*.xes'):
        log_prg = xes2lp(log)
        with open(Path(log_folder) / (log.stem + '.lp'), 'w') as f:
            f.write(log_prg)

    sys.exit(0)
