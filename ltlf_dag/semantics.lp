constraint_formula(C,@substitute(BaseFormula,B)) :- constraint(C, Template, B), template(Template, BaseFormula).
% Covers all binary operators

subformula(LHS;RHS) :- subformula((_,LHS,RHS)).

root(C, @substitute(Formula,Bindings)) :-
  constraint(C, Template, Bindings), 
  template(Template, Formula).

% Covers all unary operators
ltlf_unary(negate; next; eventually; always).
ltlf_binary(until; and; or; implies; equals; release).
subformula(F) :- root(_,F).
subformula(F) :- subformula((OP,F)), ltlf_unary(OP).
subformula(LHS;RHS) :- subformula((OP,LHS,RHS)), ltlf_binary(OP).

% Subformula F on trace TID @ time T

last(TID,T) :- trace(TID,T,_), not trace(TID,T+1,_).

% Atomic
eval(F,T,TID) :- 
    % An atomic subformula involving Arg
	subformula(F), F = (atom,A),
	trace(TID,T,A).

% Next
eval(F,T,TID) :-
	subformula(F), F = (next, F),
	eval(F, T+1, TID),
	trace(TID,T,_),
	not last(TID,T).

% Until
eval(F,T,TID) :-
	subformula(F), F = (until,LHS,RHS),
	eval(RHS,T,TID),
	trace(TID,T,_).

eval(F,T,TID) :-
	subformula(F), F = (until,LHS,RHS),
	eval(LHS,T,TID),
	eval(F,T+1,TID),
	trace(TID,T,_).

% Eventually
eval(F,T,TID) :- 
	subformula(F), F = (eventually,G),
	eval(G,T,TID).

eval(F,T,TID) :-
	subformula(F), F = (eventually,G),
	eval(F,T+1,TID),
	trace(TID,T,_).

% Always
eval(F,T,TID) :-
	subformula(F), F = (always,G),
	last(TID,T),
	eval(G,T,TID).

eval(F,T,TID) :-
	subformula(F), F = (always,G),
	eval(F,T+1,TID),
	eval(G,T,TID),
	trace(TID,T,_).

% And
eval(F,T,TID) :-
	subformula(F), F = (conjunction,LHS,RHS),
	eval(LHS,T,TID),
	eval(RHS,T,TID).

% Or
eval(F,T,TID) :-
	subformula(F), F = (disjunction,LHS,RHS),
	1 { eval(LHS,T,TID); eval(RHS,T,TID) },
	trace(TID,T,_).

% Negate
eval(F,T,TID) :-
	subformula(F), F = (negate,G),
	trace(TID,T,_),
	not eval(G,T,TID).

% Implies
eval(F,T,TID) :-
	subformula(F), F = (implies,LHS,RHS),
	1 {not eval(LHS,T,TID); eval(RHS,T,TID)},
	trace(TID,T,_).

% Release -- TODO

% True -- TODO

% False -- TODO

% Last -- TODO


sat(method(ltlf_dag),C,TID) :- eval(F,0,TID), root(C,F).
