% Absence
fail(C, TID) :-
  constraint(C, "Absence"),
  bind(C, arg_0, X),
  trace(TID,_,X).

% Existence
fail(C, TID) :-
  constraint(C, "Existence"),
  bind(C, arg_0, X),
  not trace(TID, _, X), 
  trace(TID, _, _).

% Responded Existence
fail(C,TID) :-
  constraint(C, "Responded Existence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,_,X), 
  not trace(TID,_,Y).

% Response
witness(C,T,TID) :- 
  constraint(C, "Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), trace(TID, T', Y), T' > T.

fail(C,TID) :-
  constraint(C, "Response"),
  bind(C, arg_0, X), 
  trace(TID, T, X), 
  not witness(C,T,TID).
 
% Alternate Response
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

% Chain Response
fail(C,TID) :- 
  constraint(C, "Chain Response"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X), 
  not trace(TID,T+1,Y).

% Precedence
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


% Alternate Precedence
witness(C, T2, TID) :-
  trace(TID, T2, Y),
  T0 = #max{T: trace(TID, T, Y), T2> T},
  trace(TID, T1, X),
  T2 > T1, T1 > T0,
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y).

fail(C, TID) :-
  constraint(C, "Alternate Precedence"),
  bind(C, arg_0, X),
  bind(C, arg_1, Y),
  trace(TID, T, Y),
  not witness(C, T, TID).

%                               v
% (~arg_1 W arg_0) & G(arg_1 -> X(~arg_1 W arg_0))
% in alternate precedence, le tracce non possono finire con l'activation!?
fail(C, TID) :-
  constraint(C, "Alternate Precedence"), 
  bind(C, arg_1, Y), 
  trace(TID, T, Y), 
  not trace(TID, T+1, _).

% Chain Precedence
fail(C, TID) :- 
  constraint(C, "Chain Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,T,Y),
  not trace(TID,T-1,X).

% Co-Existence
fail(C,TID) :-
  constraint(C, "Co Existence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,_,_),
  trace(TID,_,X), 
  not trace(TID,_,Y).

fail(C,TID) :-
  constraint(C, "Co Existence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,_,_),
  trace(TID,_,Y), 
  not trace(TID,_,X).

sat(method(adhoc),C,TID) :- constraint(C,_), not fail(C, TID), trace(TID,_,_).
