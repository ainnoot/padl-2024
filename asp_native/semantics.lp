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
  constraint(C, "Coexistence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,_,_),
  trace(TID,_,X), 
  not trace(TID,_,Y).

fail(C,TID) :-
  constraint(C, "Coexistence"),
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
fail(C,TID) :-
  constraint(C, "Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T',Y),
  T = #min{Q: trace(TID,Q,X)},
  trace(TID,T,X),
  T' < T.

fail(C,TID) :-
  constraint(C, "Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,Y),
  not trace(TID,_,X).

% constraint(C, "Response"; "Precedence") :- constraint(C, "Succession").
fail(C,TID) :-
  constraint(C, "Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T',Y),
  T = #min{Q: trace(TID,Q,X)},
  trace(TID,T,X),
  T' < T.

fail(C,TID) :-
  constraint(C, "Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,Y),
  not trace(TID,_,X).

witness(C,T,TID) :- 
  constraint(C, "Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), trace(TID, T', Y), T' > T.

fail(C,TID) :-
  constraint(C, "Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  not witness(C,T,TID).

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

fail(C,TID) :-
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T',Y),
  T = #min{Q: trace(TID,Q,X)},
  trace(TID,T,X),
  T' < T.

fail(C,TID) :-
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,Y),
  not trace(TID,_,X).

fail(C,TID) :-
  constraint(C, "Alternate Precedence"), 
  bind(C, arg_0, X),
  bind(C, arg_1, Y), 
  trace(TID, T0, Y), 
  trace(TID, T2, Y),
  T2 > T0,
  #count{Q: trace(TID,Q,X), Q >= T0, Q <= T2} = 0.

% Template: Alternate Succession
% Description: Combination of alternate response and alternate precedence. 
% Fails when: (i) Alternate Response fails; (ii) Alternate Precedence fails.

%constraint(C, "Alternate Response") :- constraint(C, "Alternate Succession").
%constraint(C, "Alternate Precedence") :- constraint(C, "Alternate Succession").

witness(C,T,TID) :-
  constraint(C, "Alternate Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X),
  T'' = #min{Q: trace(TID,Q,X), Q > T}, 
  trace(TID,T',Y), T'' > T', T' > T.

fail(C,TID) :- 
  constraint(C, "Alternate Succession"),
  bind(C, arg_0, X), 
  trace(TID,T,X), 
  not witness(C,T,TID).

witness(C, T2, TID) :-
  trace(TID, T2, Y),
  T0 = #max{T: trace(TID, T, Y), T2> T},
  trace(TID, T1, X),
  T2 > T1, T1 > T0,
  constraint(C, "Alternate Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y).

fail(C, TID) :-
  constraint(C, "Alternate Succession"),
  bind(C, arg_0, X),
  bind(C, arg_1, Y),
  trace(TID, T, Y),
  not witness(C, T, TID).

%%% CHECK AUTOMATA
fail(C, TID) :-
  constraint(C, "Alternate Succession"), 
  last(TID, T), 
  bind(C, arg_1, Y), 
  trace(TID, T, Y).

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

fail(C,TID) :- 
  constraint(C, "Chain Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X), 
  not trace(TID,T+1,Y).

fail(C, TID) :- 
  constraint(C, "Chain Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,T+1,Y),
  trace(TID,T,_),     % first state is not next of someone!
  not trace(TID,T,X).

sat(adhoc, C, TID) :- constraint(C,_), trace(TID,_,_), not fail(C,TID).
