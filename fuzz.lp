#script(python)

def print_witness(model):
	trace = []
	for symbol in model.symbols(atoms=True):
		if symbol.name != 'trace':
			continue
		trace.append((symbol.arguments[1].number, symbol.arguments[2].string))
	trace.sort(key=lambda x: x[0])
	trace_string = ''.join(x[1] for x in trace)

	print("Found a trace where two methods mismatch:", trace_string)

def main(ctl):
	ctl.ground([("base",[])])
	ctl.solve(on_model=print_witness)
#end.

% Idea: Search for a trace that causes an encoding 
% to mismatch wrt the automata.
%
% SAT   -> the encoding is wrong
% UNSAT -> encoding 'works' up to this length
%

% It is sufficient to test on an alphabet of k+1 activities
% if the formula contains k variables, since semantics
% is oblivious to other ones.
%
% Example:
% (x,y,z,w) |= Response(x,y) ~~~> (a,b,*,*) |= Response(a,b)
% (t,u,q,t) |= Response(t,u) ~~~> (a,b,*,a) |= Response(a,b)
%
% where `a` is the pattern activation, `b` is the pattern target
% 

#const t=6.
time(0..t-1).
activity("*").
activity(A) :- bind(_,_,A).
1 { trace(1,T,A): activity(A) } 1 :- time(T).

% count = 2 -> both SAT
% count = 0 -> both UNSAT
% count = 1 -> counterexample
:- #count{M: sat(M,C,_)} != 1, constraint(C, _).

#show.
#show sat/3.
#show trace/3.
#show constraint/2.
#show holds/2.
#show fail/2.
#show bind/3.
#show fail/2.
#show fail/3.
#show witness/3.
#show holds/2.
