last(TID,T) :- trace(TID,T,_), not trace(TID,T+1,_).

% Template: Choice
% Description: `arg_0` or `arg_1` must be executed.
% Fails when: `arg_0`, `arg_1` are never executed.
fail(C, TID) :-
  constraint(C, "Choice"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, _, _), 
  not trace(TID, _, X),
  not trace(TID, _, Y).
  
% Template: Exclusive Choice
% Description: Either `arg_0` or `arg_1` must be executed, but not both.
% Fails when: (i) `arg_0`, `arg_1` are never executed; (ii) `arg_0`, `arg_1` are both executed.
fail(C, TID) :-
  constraint(C, "Exclusive Choice"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,X),
  trace(TID,_,Y).

fail(C, TID) :-
  constraint(C, "Exclusive Choice"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, _, _), 
  not trace(TID, _, X), 
  not trace(TID, _, Y).

% Template: Responded Existence
% Description: If `arg_0` is executed, then `arg_1` must be executed as well.
% Fails when: `arg_0` is executed and `arg_1` is not.
fail(C,TID) :-
  constraint(C, "Responded Existence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,X), 
  not trace(TID,_,Y).

% Template: Coexistence
% Description: Either `arg_0` and `arg_1` are both executed, or none of them is executed.
% Fails when: (i) `arg_0` is executed, `arg_1` is not; (ii) `arg_0` is not executed, `arg_1` is.
fail(C,TID) :-
  constraint(C, "Co-Existence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,_,_),
  trace(TID,_,X), 
  not trace(TID,_,Y).

fail(C,TID) :-
  constraint(C, "Co-Existence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,_,_),
  trace(TID,_,Y), 
  not trace(TID,_,X).

% Template: Response
% Description: Every time `arg_0` is executed, `arg_1` must be executed afterwards.
% Fails when: `arg_0` is executed and `arg_1` is not executed afterwards.

witness(C,T,TID) :- 
  constraint(C, "Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), trace(TID, T', Y), T' > T.

fail(C,TID) :-
  constraint(C, "Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  not witness(C,T,TID).

% Template: Precedence
% Description: `arg_1` can be executed only if `arg_0` has been executed before
% Fails when: `arg_1` is executed, but `arg_0` has not been executed beforehand.

%%% PADL
not_first_occurrence_precedence_arg0(C,TID,T') :-
  constraint(C, "Precedence"),
  bind(C, arg_0, X), 
  trace(TID, T', X),
  trace(TID, T, X),
  T < T'.
  
fail(C,TID) :-
  constraint(C, "Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T',Y),
  trace(TID,T,X),
  not not_first_occurrence_precedence_arg0(C,TID,T),
  T' < T.

fail(C,TID) :-
  constraint(C, "Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,Y),
  not trace(TID,_,X).
%%% PADL 

constraint(r(C), "Response") :- constraint(C, "Succession").
bind(r(C), arg_0, X) :- constraint(C, "Succession"), bind(C, arg_0, X). 
bind(r(C), arg_1, Y) :- constraint(C, "Succession"), bind(C, arg_1, Y).
aux_constraint(r(C)) :- constraint(C, "Succession").

constraint(p(C), "Precedence") :- constraint(C, "Succession").
bind(p(C), arg_0, X) :- constraint(C, "Succession"), bind(C, arg_0, X). 
bind(p(C), arg_1, Y) :- constraint(C, "Succession"), bind(C, arg_1, Y).
aux_constraint(p(C)) :- constraint(C, "Succession").

fail(C,TID) :-
  constraint(C, "Succession"),
  fail(r(C), TID).

fail(C,TID) :-
  constraint(C, "Succession"),
  fail(p(C), TID).

% Template: Alternate Response
% Description: Every `arg_0` must be followed by `arg_1`, without any other `arg_0` in between.
% Fails when: (i) `arg_0` re-occurs before an `arg_1` occurs; (ii) Response fails.
witness(C,T,TID) :-
  constraint(C, "Alternate Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X),
  T'' = #min{Q: trace(TID,Q,X), Q > T}, 
  trace(TID,T',Y), T'' > T', T' > T.

fail(C,TID) :- 
  constraint(C, "Alternate Response"),
  bind(C, arg_0, X), 
  trace(TID,T,X), 
  not witness(C,T,TID).

% Template: Alternate Precedence
% Description: Every `arg_1` must be preceded by `arg_0`, without any other `arg_1` in between.
% Every b must be preceded by a, without any other b inbetween

%%% PADL
not_first_occurrence_altprec_arg0(C,TID,T) :-
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X), 
  trace(TID,T,X),
  trace(TID,T',X),
  T' < T.

fail(C,TID) :-
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X),
  not not_first_occurrence_altprec_arg0(C,TID,T),
  trace(TID,T',Y),
  T' < T.

fail(C,TID) :-
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,Y),
  not trace(TID,_,X).

not_adjacent_altprec_arg1(C,TID,T0,T2) :- 
  constraint(C, "Alternate Precedence"), 
  bind(C, arg_1, Y), 
  trace(TID, T0, Y), 
  trace(TID, T2, Y),
  T2 > T0,
  trace(TID, T, Y),
  T2 > T,
  T > T0.

adjacent_altprec_arg1(C,TID,T0,T2) :-
  constraint(C, "Alternate Precedence"), 
  bind(C, arg_1, Y), 
  trace(TID, T0, Y), 
  trace(TID, T2, Y),
  T2 > T0,
  not not_adjacent_altprec_arg1(C,TID,T0,T2).

arg0_between_adjacent_arg1(C,TID,T0,T2) :-
  constraint(C, "Alternate Precedence"), 
  bind(C, arg_0, X),
  bind(C, arg_1, Y), 
  adjacent_altprec_arg1(C,TID,T0,T2),
  trace(TID,T,X),
  T2 > T,
  T > T0.

fail(C,TID) :-
  adjacent_altprec_arg1(C,TID,T0,T2),
  not arg0_between_adjacent_arg1(C,TID,T0,T2).
%%%% PADL



% Template: Alternate Succession
% Description: Combination of alternate response and alternate precedence. 
% Fails when: (i) Alternate Response fails; (ii) Alternate Precedence fails.

constraint(ar(C), "Alternate Response") :- constraint(C, "Alternate Succession").
bind(ar(C), arg_0, X) :- constraint(C, "Alternate Succession"), bind(C, arg_0, X). 
bind(ar(C), arg_1, Y) :- constraint(C, "Alternate Succession"), bind(C, arg_1, Y).
aux_constraint(ar(C)) :- constraint(C, "Alternate Succession").

constraint(ap(C), "Alternate Precedence") :- constraint(C, "Alternate Succession").
bind(ap(C), arg_0, X) :- constraint(C, "Alternate Succession"), bind(C, arg_0, X). 
bind(ap(C), arg_1, Y) :- constraint(C, "Alternate Succession"), bind(C, arg_1, Y).
aux_constraint(ap(C)) :- constraint(C, "Alternate Succession").

fail(C,TID) :-
  constraint(C, "Alternate Succession"),
  fail(ar(C), TID).

fail(C,TID) :-
  constraint(C, "Alternate Succession"),
  fail(ap(C), TID).

% Template: Chain Response
% Description: If `arg_0` is executed then `arg_1` must be executed next.
% Fails when: `arg_0` is executed, `arg_1` does not immediately follow.

fail(C,TID) :- 
  constraint(C, "Chain Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X), 
  not trace(TID,T+1,Y).

% Template: Chain Precedence
% Description: Task `arg_1` can be executed only immediately after `arg_0`

fail(C, TID) :- 
  constraint(C, "Chain Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,T+1,Y),
  trace(TID,T,_),     % first state is not next of someone!
  not trace(TID,T,X).

fail(C, TID) :-
  constraint(C, "Chain Precedence"), 
  bind(C, arg_1, Y), 
  trace(TID, 0, Y).

% Chain Succession
% ChainSuccession(a,b) := ChainResponse(a,b) & ChainPrecedence(a,b)
% Thus it has the union of failures 
% Chain Precedence

%constraint(C, "Chain Response") :- constraint(C, "Chain Succession").
%constraint(C, "Chain Precedence") :- constraint(C, "Chain Succession").

constraint(cr(C), "Chain Response") :- constraint(C, "Chain Succession").
bind(cr(C), arg_0, X) :- constraint(C, "Chain Succession"), bind(C, arg_0, X). 
bind(cr(C), arg_1, Y) :- constraint(C, "Chain Succession"), bind(C, arg_1, Y).
aux_constraint(cr(C)) :- constraint(C, "Chain Succession").

constraint(cp(C), "Chain Precedence") :- constraint(C, "Chain Succession").
bind(cp(C), arg_0, X) :- constraint(C, "Chain Succession"), bind(C, arg_0, X). 
bind(cp(C), arg_1, Y) :- constraint(C, "Chain Succession"), bind(C, arg_1, Y).
aux_constraint(cp(C)) :- constraint(C, "Chain Succession").

fail(C, TID) :-
  constraint(C, "Chain Succession"),
  fail(cr(C), TID).

fail(C,TID) :-
  constraint(C, "Chain Succession"),
  fail(cp(C), TID).

sat(adhocopt, C, TID) :- constraint(C,_), trace(TID,_,_), not fail(C,TID).
