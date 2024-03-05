:- bind(C,Arg,_), constraint(C, T), not template(T, atom(_,Arg)).

:- template(T, atom(_,Arg)), constraint(C,T), not bind(C, Arg, _).

last(TID,T) :- trace(TID,T,_), not trace(TID,T+1,_).

sat(method(ltlf_base),C,TID) :- true(C, 0, 0, TID).

%%%% These follow the Stepped Normal Form: 
%%%% https://drops.dagstuhl.de/opus/volltexte/2021/14784/pdf/LIPIcs-TIME-2021-8.pdf

% Atomic
% Original: true(F,S):- formulaIsAtom(F,A), state(S), true(A,S).
true(C, F, T, TID) :-
  constraint(C, Template),
  template(Template, atom(F, Arg)),
  bind(C, Arg, A),
  trace(TID, T, A).

% And
% Original: true(F,S):- conjunction(F,G,H), state(S), true(G,S), true(H,S).
true(C, F, T, TID) :- 
  constraint(C, Template), 
  template(Template, conjunction(F, G, H)), 
  trace(TID, T, _), 
  true(C, G, T, TID), 
  true(C, H, T, TID).

% Or
% Original: true(F,S):- disjunction(F,G,H), state(S), 1{true(G,S); true(H,S)}.
true(C, F, T, TID) :- 
  constraint(C, Template), 
  template(Template, disjunction(F, G, H)), 
  trace(TID, T, _), 
  1 { true(C, G, T, TID); true(C, H, T, TID) }.

% Negate
% Original: true(F,S):- negation(F,G), state(S), not true(G,S).
true(C, F, T, TID) :-
  constraint(C, Template), 
  template(Template, negate(F, G)), 
  not true(C, G, T, TID), 
  trace(TID, T, _).

% Implies
true(C, F, T, TID) :- 
  constraint(C, Template), 
  template(Template, implies(F, G, H)), 
  trace(TID, T, _), 
  1 { not true(C, G, T, TID); true(C, H, T, TID) }.

% Next
% Original: true(F,Si):- next(F,G), state(Si), Sj=Si+1, Si<M, finalState(M), true(G,Sj).
true(C, F, Ti, TID) :-
  constraint(C, Template), 
  template(Template, next(F,G)), 
  trace(TID, Ti, _), 
  Tj = Ti + 1, 
  Ti < M,
  last(TID, M), 
  true(C, G, Tj, TID).

% WNext
true(C, F, Ti, TID) :-
  constraint(C, Template),
  template(Template, weak_next(F,G)),
  trace(TID, Ti, _),
  Tj = Ti + 1,
  Ti < M,
  last(TID, M),
  true(C, G, Tj, TID).

true(C, F, Ti, TID) :-
  constraint(C, Template), 
  template(Template, weak_next(F,G)),
  trace(TID, Ti, _),
  last(TID, Ti).
  
% Prec(a,b) ~ !b W a ~ !b U a | G(!b) -> {!, U, G}

% Until
% Originl: true(F,Si):- until(F,G,H), state(Si), state(Sj), Sj>Si, Sj<=M, finalState(M), X{true(G,S):  state(S), S>=Si, S<Sj}X, X=Sj-Si, true(H,Sj).
true(C, F, Ti, TID) :- 
  constraint(C, Template), 
  template(Template, until(F,G,H)), 
  trace(TID, Ti, _), 
  trace(TID, Tj, _),

  % Nella definizione di Until j >= i ...
  Tj >= Ti,
  Tj <= M,
  last(TID, M),
  X { true(C,G,T,TID): trace(TID,T,_), T >= Ti, T < Tj} X,
  X = Tj - Ti,
  true(C, H, Tj, TID).

% Always
% Original: true(F,Si):- globally(F,G), state(Si), X{true(G,S): state(S), S>Si}X, finalState(M), X=M-Si.
true(C, F, Ti, TID) :- 
  constraint(C, Template), 
  template(Template, always(F,G)), 
  trace(TID, Ti, _), 
  X { true(C, G, T, TID): trace(TID, T, _), T >= Ti } X,
  last(TID, M),

  % first time-step is 0, not 1 ...
  X = M - Ti + 1.

% Eventually
% Original: true(F,Si):- eventually(F,G), state(Si), true(G,Sj), state(Sj), Sj>Si.
true(C, F, Ti, TID) :-
  constraint(C, Template),
  template(Template, eventually(F,G)), 
  trace(TID, Ti, _), 
  true(C, G, Tj, TID), 
  trace(TID, Tj, _), 
  Tj >= Ti.					% t=0

