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
  T0 = #max{T: trace(TID, T, Y), T < T2},
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

% Chain Precedence
fail(C, TID) :- 
  constraint(C, "Chain Precedence"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,T,Y),
  T > 0,
  not trace(TID,T-1,X).

% Co-Existence
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

% Succession

%%%%% vengono da Response
witness(C,T,TID) :- 
  constraint(C, "Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID, T, X), trace(TID, T', Y), T' > T.

fail(C,TID) :-
  constraint(C, "Succession"),
  bind(C, arg_0, X), 
  trace(TID, T, X), 
  not witness(C,T,TID).
%%%%%%

%%%%%% vengono da Precedence
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
%%%%%%

% Alternate Succession 

%%%% vengono da alternate response
witness(C,T,TID,response) :-
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
  not witness(C,T,TID, response).
%%%%%%

%%%% vengono da alternate precedence
witness(C, T2, TID, precedence) :-
  trace(TID, T2, Y),
  T0 = #max{T: trace(TID, T, Y), T < T2},
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
  not witness(C, T, TID, precedence).
%%%%

% Chain Succession
% viene da chain response
fail(C,TID) :- 
  constraint(C, "Chain Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y), 
  trace(TID,T,X), 
  not trace(TID,T+1,Y).

% viene da chain precedence
fail(C, TID) :- 
  constraint(C, "Chain Succession"),
  bind(C, arg_0, X), 
  bind(C, arg_1, Y),
  trace(TID,T,Y),
  T > 0,
  not trace(TID,T-1,X).

sat(method(adhoc),C,TID) :- constraint(C,_), not fail(C, TID), trace(TID,_,_).
