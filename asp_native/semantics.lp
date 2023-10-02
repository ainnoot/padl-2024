last(TID,T) :- trace(TID,T,_), not trace(TID,T+1,_).

% Template: Existence(arg_0)
% Description: `arg_0` must be executed at least once.
% Fails when: `arg_0` is never executed.
%fail(C, TID) :-
%  constraint(C, "Existence1"),
%  bind(C, arg_0, X),
%  not trace(TID, _, X), 
%  trace(TID, _, _).

% Template: Absence 2
% Description: `arg_0` can be executed at most once.
% Fails when: `arg_0` is executed at least two times.
%fail(C, TID) :-
%  constraint(C, "Absence"),
%  bind(C, arg_0, X),
%  trace(TID,T,X), 
%  trace(TID,T',X),
%  T' > T.

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

% Template: Succession
% Description: `arg_1` must be executed after `arg_0`, and `arg_0` must precede `arg_1`
% Fails when: (i) Response fails; (ii) Precedence fails.

% vvv this is very elegant, but wrong!
% fail/2 definition for response due to missing witnesses mixes with fail/2 definition for precedence
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

%%% d4py
witness_ar_r(C,T,TID) :- 
  constraint(C, "Alternate Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), trace(TID, T', Y), T' > T.

fail(C,TID) :-
  constraint(C, "Alternate Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  not witness_ar_r(C,T,TID).
%%%%

fail(C,TID) :- 
  constraint(C, "Alternate Response"),
  bind(C, arg_0, X), 
  trace(TID,T,X), 
  not witness(C,T,TID).

% Template: Alternate Precedence
% Description: Every `arg_1` must be preceded by `arg_0`, without any other `arg_1` in between.

witness(C, T2, TID) :-
  trace(TID, T2, Y),
  T0 = #max{T: trace(TID, T, Y), T2> T},
  trace(TID, T1, X),
  T2 > T1, T1 > T0,
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y).

%%% D4Py
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
%%% D4Py

fail(C, TID) :-
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X),
  bind(C, arg_1, Y),
  trace(TID, T, Y),
  not witness(C, T, TID).

%%% CHECK AUTOMATA
fail(C, TID) :-
  constraint(C, "Alternate Precedence"), 
  last(TID, T), 
  bind(C, arg_1, Y), 
  trace(TID, T, Y).

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

%%% d4py
witness_cr_r(C,T,TID) :- 
  constraint(C, "Chain Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), trace(TID, T', Y), T' > T.

fail(C,TID) :-
  constraint(C, "Chain Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  not witness_cr_r(C,T,TID).
%%%%

% Template: Chain Precedence
% Description: Task `arg_1` can be executed only immediately after `arg_0`

fail(C, TID) :- 
  constraint(C, "Chain Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,T+1,Y),
  trace(TID,T,_),     % first state is not next of someone!
  not trace(TID,T,X).

%%% d4py
fail(C,TID) :-
  constraint(C, "Chain Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T',Y),
  T = #min{Q: trace(TID,Q,X)},
  trace(TID,T,X),
  T' < T.

fail(C,TID) :-
  constraint(C, "Chain Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,Y),
  not trace(TID,_,X).
%%%%

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


% Template: Not Coexistence
% Description: Only one among tasks `arg_0`, `arg_1` can be executed, but not both 
fail(C,TID) :-
  constraint(C, "Not Coexistence"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,X),
  trace(TID,_,Y).

% Template: Not Succession
% Description: Task `arg_0` cannot be followed by `arg_1` and task `arg_1` cannot be preceded by `arg_0`

fail(C, TID) :-
  constraint(C, "Not Succession"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  trace(TID, T', Y), 
  T' > T.

% Template: Not Chain Succession
% Description: Task `arg_0` and `arg_1` cannot be executed next to each other
fail(C, TID) :-
  constraint(C, "Not Chain Succession"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X),
  trace(TID,T+1,Y).
  
fail(C, TID) :-
  constraint(C, "Not Chain Succession"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,NX),
  NX != X,
  trace(TID,T+1,NY),
  NY != Y.

fail(C,TID) :- 
  constraint(C, "Not Chain Succession"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,NX),
  NX != X,
  last(TID,T).


%%% non sono nel paper ma in declare4py si 
%%% tesi https://amslaurea.unibo.it/22501/1/tesi.pdf

fail(C,TID) :-
  constraint(C, "Not Responded Existence"),
  bind(C, arg_0, X),
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  trace(TID, T', Y).

fail(C,TID) :-
  constraint(C, "Not Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  trace(TID, T', Y), 
  T' > T.

fail(C,TID) :-
  constraint(C, "Not Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  trace(TID, T', Y), 
  T' > T.

%fail(C,TID) :-
%  constraint(C, "Not Chain Response"),
%  bind(C, arg_0, X), 
%  bind(C, arg_1, Y), 
%  ...

fail(C,TID) :-
  constraint(C, "Not Chain Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X),
  trace(TID,T+1,Y).

fail(C,TID) :-
  constraint(C, "Not Chain Response"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  trace(TID, T+1, Y).

fail(C,TID) :-
  constraint(C, "Not Chain Response"), 
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), 
  not trace(TID, T+1, _).


sat(adhoc, C, TID) :- constraint(C,_), trace(TID,_,_), not fail(C,TID).
