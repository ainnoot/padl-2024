constraint(0,"Chain Response").
bind(0, arg_0, "Admission IC").
var_bind(0, arg_1, var(x)).

domain(var(x),A) :- trace(_,_,A).
{ bind(C, Arg, Value): domain(Var, Value) } = 1 :- var_bind(C, Arg, Var).
:- #count{TID: not sat(_, C, TID), constraint(C,_), trace(TID,_,_)} > 150.
