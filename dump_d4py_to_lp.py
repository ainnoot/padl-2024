def dump_checker_as_tuples(df):
	tuples = []
	for tid, constraints in df.iterrows():
		for cid, state in enumerate(constraints):
			if state == 1:
				tuples.append("({},{})".format(cid,tid))
	return tuples

