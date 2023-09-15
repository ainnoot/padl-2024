% All args must be bound in constraints
:- bind(C,Arg,_), constraint(C, T), not template(T, atom(_,Arg)).

% Don't bind unknown parameters
:- template(T, atom(_,Arg)), constraint(C,T), not bind(C, Arg, _).

% A state is the last state if it does not have a next state
last(TID,T) :- trace(TID,T,_), not trace(TID,T+1,_).

% A trace models a constraint if its root subformula (0) is true in the first state
% eval(Subformula, Constraint, Time, Trace)
sat(C,TID) :- eval(0, C, 0, TID).

%%%% These follow the Stepped Normal Form: 
%%%% https://drops.dagstuhl.de/opus/volltexte/2021/14784/pdf/LIPIcs-TIME-2021-8.pdf

% Atomic
eval(S,C,T,TID) :-
  constraint(C,Template),
  template(Template, atom(S,Arg)),
  bind(C, Arg, A), 
  trace(TID,T,A).

% Next
eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, next(S,F)),
  not last(TID,T),
  trace(TID,_,_),
  eval(F,C,T+1,TID).

% Until
eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, until(S,LHS,RHS)),
  eval(RHS,C,T,TID),
  trace(TID,T,_).

eval(S,C,T,TID) :-
  constraint(C, Template),
  template(Template, until(S,LHS,RHS)),
  eval(LHS,C,T,TID),
  eval(S,C,T+1,TID),
  trace(TID,T,_).

% Eventually
eval(S,C,T,TID) :- 
  constraint(C, Template),
  template(Template, eventually(S,F)), 
  eval(F,C,T,TID).

eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, eventually(S,F)), 
  eval(S,C,T+1,TID), 
  trace(TID, T, _).

% Always
eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, always(S,F)), 
  last(TID, T), 
  eval(F,C,T,TID).

eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, always(S,F)), 
  eval(S,C,T+1,TID), 
  trace(TID, T, _).

% And
eval(S,C,T,TID) :-
  constraint(C, Template),
  template(Template, conjunction(S,LHS,RHS)),
  eval(LHS,C,T,TID),
  eval(RHS,C,T,TID),
  trace(TID,T,_).

% Or
eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, disjunction(S,LHS,RHS)),
  1 {eval(LHS,C,T,TID); eval(RHS,C,T,TID) },
  trace(TID,T,_).

% Negate
eval(S,C,T,TID) :- 
  constraint(C, Template),
  template(Template, negate(S,F)), 
  not eval(F,C,T,TID), 
  trace(TID,T,_).

% Implies
eval(S,C,T,TID) :-
  constraint(C, Template),
  template(Template, implies(S,LHS,RHS)), 
  1 { not eval(LHS,C,T,TID); eval(RHS,C,T,TID) },
  trace(TID,T,_).

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

% Release
% snf(a R b) = snf(b) & (snf(a) | X(a R b)
% snf(a R b) = snf(b) & snf(a)
%           |= snf(b) & X(a R b)

eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, release(S,LHS,RHS)),
  eval(LHS,C,T,TID),
  eval(RHS,C,T,TID),
  trace(TID,T,_).

eval(S,C,T,TID) :-
  constraint(C, Template), 
  template(Template, release(S,LHS,RHS)), 
  eval(RHS,C,T,TID), 
  eval(S,C,T+1,TID),
  trace(TID,T,_).

#show.
#show satisfied/2.
