import pm4py
import sys
from pathlib import Path

log_folder = sys.argv[1]

def compute_trace_length(log):
	event_log = pm4py.read_xes(log.as_posix(), return_legacy_log_object=True)

	cumulative_length = 0
	for trace in event_log:
		cumulative_length += len(trace)		

	return cumulative_length / len(event_log)
	

for log in Path(log_folder).glob('*.xes'):
	event_log_df = pm4py.read_xes(log.as_posix())
	activities = event_log_df['concept:name'].unique()
	print("%" * 80)
	print("Log:", log.stem)
	print("Num. Activities:", len(activities))
	print("Num. traces:", len(event_log_df['case:concept:name'].unique()))
	print("Avg. trace length:", compute_trace_length(log))
	print("%" * 80)
