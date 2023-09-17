import pm4py


def xes2lp(log_file):
    log = pm4py.read_xes(log_file)
    nb_traces = len(log)
    f = open(log_file[:-3]+'lp','w')
    for i in range(nb_traces):
        trace = log[i]
        for j in range(len(trace)):
            event = trace[j]
            event_name = '"'+event['concept:name']+'"'
            f.write('trace({},{},{}).\n'.format(i,j,event_name))
        f.write('\n')
    f.close() 
    
import sys 

if __name__ == '__main__':
    log_file = sys.argv[1]
    xes2lp(log_file)
    
