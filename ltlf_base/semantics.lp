% All args must be bound in constraints
:- bind(C,Arg,_), constraint(C, T), not template(T, atom(_,Arg)).

% Don't bind unknown parameters
:- template(T, atom(_,Arg)), constraint(C,T), not bind(C, Arg, _).

% A state is the last state if it does not have a next state
last(TID,T) :- trace(TID,T,_), not trace(TID,T+1,_).

% A trace models a constraint if its root subformula (0) is true in the first state
% eval(Subformula, Constraint, Time, Trace)
sat(method(ltlf_base),C,TID) :- eval(0, C, 0, TID).

%%%% These follow the Stepped Normal Form: 
%%%% https://drops.dagstuhl.de/opus/volltexte/2021/14784/pdf/LIPIcs-TIME-2021-8.pdf

% Atomic
% true(F,S):- formulaIsAtom(F,A), state(S), true(A,S).
eval(S,C,T,TID) :-
  constraint(C,Template),
  template(Template, atom(S,Arg)),
  bind(C,Arg,A),
  trace(TID,T,A).

% And
% true(F,S):- conjunction(F,G,H), state(S), true(G,S), true(H,S).
eval(S,C,T,TID) :-
  constraint(C, Template),
  template(Template, conjunction(S,LHS,RHS)),
  eval(LHS,C,T,TID),
  eval(LHS,C,T,TID).

% Or
% 3 true(F,S):- disjunction(F,G,H), state(S), 1{true(G,S); true(H,S)}.
eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, disjunction(S,LHS,RHS)),
  1 { eval(LHS,C,T,TID); eval(RHS,C,T,TID) },
  trace(TID,T,_).


% Negate
% true(F,S):- negation(F,G), state(S), not true(G,S).
eval(S,C,T,TID) :- 
  constraint(C, Template),
  template(Template, negate(S,F)),
  not eval(S,C,T,TID),
  trace(TID,T,_).

% Implies
% A -> B
% ~A | B
eval(S,C,T,TID) :-
  constraint(C, Template),
  template(Template, implies(S,LHS,RHS)),
  1 { not eval(LHS,C,T,TID); eval(RHS,C,T,TID) },
  trace(TID,T,_).

% Next
% true(F,Si):- next(F,G), state(Si), Sj=Si+1, Si<M, finalState(M), true(G,Sj).
eval(S,C,Ti,TID) :-
  constraint(C, Template), 
  template(Template, next(S,F)),
  trace(TID,Ti,_),
  last(TID,L),
  Ti < L,
  eval(S,C,Ti+1,TID).

% Until
% true(F,Si):- until(F,G,H), state(Si), state(Sj), Sj>Si, Sj<=M, finalState(M), X{true(G,S): state(S), S>=Si, S<Sj}X, X=Sj-Si, true(H,Sj).
eval(S,C,Ti,TID) :-
  constraint(C, Template), 
  template(Template, until(S,LHS,RHS)),
  trace(TID,Ti,_), 
  trace(TID,Tj,_), 
  Tj > Ti,
  last(TID,L),
  Tj <= L,
  X {eval(LHS,C,T,TID): trace(TID,T,_), T >= Ti, T < Tj} X, X = Tj-Ti, eval(RHS,C,Tj,TID).

% Always
% true(F,Si):- globally(F,G), state(Si), X{true(G,S): state(S), S>Si}X, finalState(M), X=M-Si.
eval(S,C,Ti,TID) :-
  constraint(C, Template), 
  template(Template, always(S,F)),
  last(TID,L),
  X = L-Ti,
  trace(TID,Ti,_),
  X {eval(F,C,T,TID): trace(TID,T,_), T > Ti } X.

% Eventually
%  eventually(F,G), state(Si), true(G,Sj), state(Sj), Sj>Si.
eval(S,C,Ti,TID) :- 
  constraint(C, Template),
  template(Template, eventually(S,F)), 
  trace(TID,Ti,_),
  trace(TID,Tj,_),
  Tj > Ti, 
  eval(F,C,Tj,TID).

% True, False, Last
eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, true(S)),
  trace(TID,T,_).

-eval(S,C,T,TID) :-
  constraint(C,Template),
  template(Template, false(S)),
  trace(TID,T,_).

eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, last(S)), 
  last(TID,T).
