% Existence -- F(arg_0)
template("Existence", eventually(0,1)).
template("Existence", atom(1,arg_0)).

% Absence 2 -- !F(arg_0 & XF(arg_0))
template("Absence 2", negate(0,1)).
template("Absence 2", eventually(1,2)).
template("Absence 2", conjunction(2,3,4)).
template("Absence 2", atom(3,arg_0)).
template("Absence 2", next(4,5)).
template("Absence 2", eventually(5,6)).
template("Absence 2", atom(6,arg_0)).

% Choice -- F(arg_0) | F(arg_1)
template("Choice", disjunction(0,1,2)).
template("Choice", eventually(1,3)).
template("Choice", eventually(2,4)).
template("Choice", atom(3,arg_0)).
template("Choice", atom(4,arg_1)).

% Exclusive Choice -- (F(arg_0) | F(arg_1)) & !(F(arg_0) & F(arg_1))
template("Exclusive Choice", conjunction(0,1,2)).
template("Exclusive Choice", disjunction(1,3,4)).
template("Exclusive Choice", negate(2,5)).
template("Exclusive Choice", eventually(3,6)).
template("Exclusive Choice", eventually(4,7)).
template("Exclusive Choice", conjunction(5,8,9)).
template("Exclusive Choice", atom(6,arg_0)).
template("Exclusive Choice", atom(7,arg_1)).
template("Exclusive Choice", eventually(8,10)).
template("Exclusive Choice", eventually(9,11)).
template("Exclusive Choice", atom(10,arg_0)).
template("Exclusive Choice", atom(11,arg_1)).

% Responded Existence -- F(arg_0) -> F(arg_1)
template("Responded Existence", implies(0,1,2)).
template("Responded Existence", eventually(1,3)).
template("Responded Existence", eventually(2,4)).
template("Responded Existence", atom(3,arg_0)).
template("Responded Existence", atom(4,arg_1)).

% Coexistence -- F(arg_0) <-> F(arg_1)
template("Coexistence", equals(0,1,2)).
template("Coexistence", eventually(1,3)).
template("Coexistence", eventually(2,4)).
template("Coexistence", atom(3,arg_0)).
template("Coexistence", atom(4,arg_1)).

% Response -- G(arg_0 -> F(arg_1))
template("Response", always(0,1)).
template("Response", implies(1,2,3)).
template("Response", atom(2,arg_0)).
template("Response", eventually(3,4)).
template("Response", atom(4,arg_1)).

% Precedence -- !arg_1 W arg_0
template("Precedence", disjunction(0,1,2)).
template("Precedence", until(1,3,4)).
template("Precedence", always(2,5)).
template("Precedence", negate(3,6)).
template("Precedence", atom(4,arg_0)).
template("Precedence", negate(5,7)).
template("Precedence", atom(6,arg_1)).
template("Precedence", atom(7,arg_1)).

% Succession -- G(arg_0 -> F(arg_1)) & (!arg_1 W arg_0)
template("Succession", conjunction(0,1,2)).
template("Succession", always(1,3)).
template("Succession", disjunction(2,4,5)).
template("Succession", implies(3,6,7)).
template("Succession", until(4,8,9)).
template("Succession", always(5,10)).
template("Succession", atom(6,arg_0)).
template("Succession", eventually(7,11)).
template("Succession", negate(8,12)).
template("Succession", atom(9,arg_0)).
template("Succession", negate(10,13)).
template("Succession", atom(11,arg_1)).
template("Succession", atom(12,arg_1)).
template("Succession", atom(13,arg_1)).

% Alternate Response -- G(arg_0 -> X(!arg_0 U arg_1))
template("Alternate Response", always(0,1)).
template("Alternate Response", implies(1,2,3)).
template("Alternate Response", atom(2,arg_0)).
template("Alternate Response", next(3,4)).
template("Alternate Response", until(4,5,6)).
template("Alternate Response", negate(5,7)).
template("Alternate Response", atom(6,arg_1)).
template("Alternate Response", atom(7,arg_0)).

% Alternate Precedence -- (!arg_1 W arg_0) & G(arg_1 -> WX(!arg_1 W arg_0))
template("Alternate Precedence", conjunction(0,1,2)).
template("Alternate Precedence", disjunction(1,3,4)).
template("Alternate Precedence", always(2,5)).
template("Alternate Precedence", until(3,6,7)).
template("Alternate Precedence", always(4,8)).
template("Alternate Precedence", implies(5,9,10)).
template("Alternate Precedence", negate(6,11)).
template("Alternate Precedence", atom(7,arg_0)).
template("Alternate Precedence", negate(8,12)).
template("Alternate Precedence", atom(9,arg_1)).
template("Alternate Precedence", weak_next(10,13)).
template("Alternate Precedence", atom(11,arg_1)).
template("Alternate Precedence", atom(12,arg_1)).
template("Alternate Precedence", disjunction(13,14,15)).
template("Alternate Precedence", until(14,16,17)).
template("Alternate Precedence", always(15,18)).
template("Alternate Precedence", negate(16,19)).
template("Alternate Precedence", atom(17,arg_0)).
template("Alternate Precedence", negate(18,20)).
template("Alternate Precedence", atom(19,arg_1)).
template("Alternate Precedence", atom(20,arg_1)).

% Alternate Succession -- G(arg_0 -> X(!arg_0 U arg_1)) & (!arg_1 W arg_0) & G(arg_1 -> WX(!arg_1 W arg_0))
template("Alternate Succession", conjunction(0,1,2)).
template("Alternate Succession", always(1,3)).
template("Alternate Succession", disjunction(2,4,5)).
template("Alternate Succession", implies(3,6,7)).
template("Alternate Succession", until(4,8,9)).
template("Alternate Succession", always(5,10)).
template("Alternate Succession", atom(6,arg_0)).
template("Alternate Succession", next(7,11)).
template("Alternate Succession", negate(8,12)).
template("Alternate Succession", atom(9,arg_0)).
template("Alternate Succession", negate(10,13)).
template("Alternate Succession", until(11,14,15)).
template("Alternate Succession", atom(12,arg_1)).
template("Alternate Succession", atom(13,arg_1)).
template("Alternate Succession", negate(14,16)).
template("Alternate Succession", atom(15,arg_1)).
template("Alternate Succession", atom(16,arg_0)).

% Chain Response -- G(arg_0 -> X(arg_1))
template("Chain Response", always(0,1)).
template("Chain Response", implies(1,2,3)).
template("Chain Response", atom(2,arg_0)).
template("Chain Response", next(3,4)).
template("Chain Response", atom(4,arg_1)).

% Chain Precedence -- G(X(arg_1) -> arg_0)
template("Chain Precedence", always(0,1)).
template("Chain Precedence", implies(1,2,3)).
template("Chain Precedence", next(2,4)).
template("Chain Precedence", atom(3,arg_0)).
template("Chain Precedence", atom(4,arg_1)).

% Chain Succession -- G(arg_0 <-> X(arg_1))
template("Chain Succession", always(0,1)).
template("Chain Succession", equals(1,2,3)).
template("Chain Succession", atom(2,arg_0)).
template("Chain Succession", next(3,4)).
template("Chain Succession", atom(4,arg_1)).

% Not Coexistence -- !(F(arg_0) & F(arg_1))
template("Not Coexistence", negate(0,1)).
template("Not Coexistence", conjunction(1,2,3)).
template("Not Coexistence", eventually(2,4)).
template("Not Coexistence", eventually(3,5)).
template("Not Coexistence", atom(4,arg_0)).
template("Not Coexistence", atom(5,arg_1)).

% Neg Succession -- G(arg_0 -> !F(arg_1))
template("Neg Succession", always(0,1)).
template("Neg Succession", implies(1,2,3)).
template("Neg Succession", atom(2,arg_0)).
template("Neg Succession", negate(3,4)).
template("Neg Succession", eventually(4,5)).
template("Neg Succession", atom(5,arg_1)).

% Neg Chain Succession -- G(arg_0 <-> X(!arg_1))
template("Neg Chain Succession", always(0,1)).
template("Neg Chain Succession", equals(1,2,3)).
template("Neg Chain Succession", atom(2,arg_0)).
template("Neg Chain Succession", next(3,4)).
template("Neg Chain Succession", negate(4,5)).
template("Neg Chain Succession", atom(5,arg_1)).

