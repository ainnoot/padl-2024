import sys
import pm4py


def xes2lp(log_file):
    log = pm4py.read_xes(log_file, return_legacy_log_object=True)
    output_target = "{}.lp".format(log_file[:-4])

    with open(output_target, 'w') as f:
        for tid, trace in enumerate(log):
            for t, event in enumerate(trace):
                f.write('trace({},{},\"{}\").\n'.format(
                    tid, t, event['concept:name']))
            f.write('\n')


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: {} [XES event log]".format(__file__))
        sys.exit(1)

    log_file = sys.argv[1]
    xes2lp(log_file)
    sys.exit(0)
