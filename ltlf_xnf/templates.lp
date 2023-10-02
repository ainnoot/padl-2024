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

% Coexistence -- (F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))
template("Coexistence", conjunction(0,1,2)).
template("Coexistence", implies(1,3,4)).
template("Coexistence", implies(2,5,6)).
template("Coexistence", eventually(3,7)).
template("Coexistence", eventually(4,8)).
template("Coexistence", eventually(5,9)).
template("Coexistence", eventually(6,10)).
template("Coexistence", atom(7,arg_0)).
template("Coexistence", atom(8,arg_1)).
template("Coexistence", atom(9,arg_1)).
template("Coexistence", atom(10,arg_0)).

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

% Alternate Precedence -- ( (!arg_1) W arg_0 ) & G( arg_1 -> X( (!arg_1) W arg_0) )
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
template("Alternate Precedence", next(10,13)).
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

% Alternate Succession -- (G(arg_0 -> X(!arg_0 U arg_1)) & (!arg_1 W arg_0)) & G(arg_1 -> X(!arg_1 W arg_0))
template("Alternate Succession", conjunction(0,1,2)).
template("Alternate Succession", conjunction(1,3,4)).
template("Alternate Succession", always(2,5)).
template("Alternate Succession", always(3,6)).
template("Alternate Succession", disjunction(4,7,8)).
template("Alternate Succession", implies(5,9,10)).
template("Alternate Succession", implies(6,11,12)).
template("Alternate Succession", until(7,13,14)).
template("Alternate Succession", always(8,15)).
template("Alternate Succession", atom(9,arg_1)).
template("Alternate Succession", next(10,16)).
template("Alternate Succession", atom(11,arg_0)).
template("Alternate Succession", next(12,17)).
template("Alternate Succession", negate(13,18)).
template("Alternate Succession", atom(14,arg_0)).
template("Alternate Succession", negate(15,19)).
template("Alternate Succession", disjunction(16,20,21)).
template("Alternate Succession", until(17,22,23)).
template("Alternate Succession", atom(18,arg_1)).
template("Alternate Succession", atom(19,arg_1)).
template("Alternate Succession", until(20,24,25)).
template("Alternate Succession", always(21,26)).
template("Alternate Succession", negate(22,27)).
template("Alternate Succession", atom(23,arg_1)).
template("Alternate Succession", negate(24,28)).
template("Alternate Succession", atom(25,arg_0)).
template("Alternate Succession", negate(26,29)).
template("Alternate Succession", atom(27,arg_0)).
template("Alternate Succession", atom(28,arg_1)).
template("Alternate Succession", atom(29,arg_1)).

% Chain Response -- G(arg_0 -> X(arg_1))
template("Chain Response", always(0,1)).
template("Chain Response", implies(1,2,3)).
template("Chain Response", atom(2,arg_0)).
template("Chain Response", next(3,4)).
template("Chain Response", atom(4,arg_1)).

% Chain Precedence -- (!arg_1 W arg_0) & G(X(arg_1) -> arg_0)
template("Chain Precedence", conjunction(0,1,2)).
template("Chain Precedence", disjunction(1,3,4)).
template("Chain Precedence", always(2,5)).
template("Chain Precedence", until(3,6,7)).
template("Chain Precedence", always(4,8)).
template("Chain Precedence", implies(5,9,10)).
template("Chain Precedence", negate(6,11)).
template("Chain Precedence", atom(7,arg_0)).
template("Chain Precedence", negate(8,12)).
template("Chain Precedence", next(9,13)).
template("Chain Precedence", atom(10,arg_0)).
template("Chain Precedence", atom(11,arg_1)).
template("Chain Precedence", atom(12,arg_1)).
template("Chain Precedence", atom(13,arg_1)).

% Chain Succession -- G(arg_0 -> X(arg_1)) & G(X(arg_1) -> arg_0)
template("Chain Succession", conjunction(0,1,2)).
template("Chain Succession", always(1,3)).
template("Chain Succession", always(2,4)).
template("Chain Succession", implies(3,5,6)).
template("Chain Succession", implies(4,7,8)).
template("Chain Succession", atom(5,arg_0)).
template("Chain Succession", next(6,9)).
template("Chain Succession", next(7,10)).
template("Chain Succession", atom(8,arg_0)).
template("Chain Succession", atom(9,arg_1)).
template("Chain Succession", atom(10,arg_1)).

% Not Coexistence -- !(F(arg_0) & F(arg_1))
template("Not Coexistence", negate(0,1)).
template("Not Coexistence", conjunction(1,2,3)).
template("Not Coexistence", eventually(2,4)).
template("Not Coexistence", eventually(3,5)).
template("Not Coexistence", atom(4,arg_0)).
template("Not Coexistence", atom(5,arg_1)).

% Not Succession -- G(arg_0 -> !F(arg_1))
template("Not Succession", always(0,1)).
template("Not Succession", implies(1,2,3)).
template("Not Succession", atom(2,arg_0)).
template("Not Succession", negate(3,4)).
template("Not Succession", eventually(4,5)).
template("Not Succession", atom(5,arg_1)).

% Not Chain Succession -- G( (arg_0 -> !X(arg_1)) & (!X(arg_1) -> arg_0) )
template("Not Chain Succession", always(0,1)).
template("Not Chain Succession", conjunction(1,2,3)).
template("Not Chain Succession", implies(2,4,5)).
template("Not Chain Succession", implies(3,6,7)).
template("Not Chain Succession", atom(4,arg_0)).
template("Not Chain Succession", negate(5,8)).
template("Not Chain Succession", negate(6,9)).
template("Not Chain Succession", atom(7,arg_0)).
template("Not Chain Succession", next(8,10)).
template("Not Chain Succession", next(9,11)).
template("Not Chain Succession", atom(10,arg_1)).
template("Not Chain Succession", atom(11,arg_1)).

% Not Responded Existence -- F(arg_0) -> !(F(arg_1))
template("Not Responded Existence", implies(0,1,2)).
template("Not Responded Existence", eventually(1,3)).
template("Not Responded Existence", negate(2,4)).
template("Not Responded Existence", atom(3,arg_0)).
template("Not Responded Existence", eventually(4,5)).
template("Not Responded Existence", atom(5,arg_1)).

% Not Response -- G(arg_0 -> !(F arg_1))
template("Not Response", always(0,1)).
template("Not Response", implies(1,2,3)).
template("Not Response", atom(2,arg_0)).
template("Not Response", negate(3,4)).
template("Not Response", eventually(4,5)).
template("Not Response", atom(5,arg_1)).

% Not Precedence -- G(F(arg_1) -> !arg_0)
template("Not Precedence", always(0,1)).
template("Not Precedence", implies(1,2,3)).
template("Not Precedence", eventually(2,4)).
template("Not Precedence", negate(3,5)).
template("Not Precedence", atom(4,arg_1)).
template("Not Precedence", atom(5,arg_0)).

% Not Chain Response -- G(arg_0 -> X(!(arg_1)))
template("Not Chain Response", always(0,1)).
template("Not Chain Response", implies(1,2,3)).
template("Not Chain Response", atom(2,arg_0)).
template("Not Chain Response", next(3,4)).
template("Not Chain Response", negate(4,5)).
template("Not Chain Response", atom(5,arg_1)).

% Not Chain Precedence -- G(X(arg_1) -> !arg_0)
template("Not Chain Precedence", always(0,1)).
template("Not Chain Precedence", implies(1,2,3)).
template("Not Chain Precedence", next(2,4)).
template("Not Chain Precedence", negate(3,5)).
template("Not Chain Precedence", atom(4,arg_1)).
template("Not Chain Precedence", atom(5,arg_0)).

