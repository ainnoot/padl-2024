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
1 { trace(1,T,A): activity(A) } 1 :- time(T).

method(automata; ltlf_base; ltlf_xnf; ltlf_dag).
unsat(M,C,TID) :- method(M), constraint(C,_), trace(TID,_,_), not sat(M,C,TID).
sat(C,TID) :- sat(_,C,TID).
unsat(C,TID) :- unsat(_,C,TID).
:- sat(C,TID), unsat(C,TID).
