% Responded Existence -- F(arg_0) -> F(arg_1)
template("Responded Existence", implies(0,1,2)).
template("Responded Existence", eventually(1,3)).
template("Responded Existence", eventually(2,4)).
template("Responded Existence", atom(3,arg_0)).
template("Responded Existence", atom(4,arg_1)).

% Co Existence -- (F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))
template("Co Existence", conjunction(0,1,2)).
template("Co Existence", implies(1,3,4)).
template("Co Existence", implies(2,5,6)).
template("Co Existence", eventually(3,7)).
template("Co Existence", eventually(4,8)).
template("Co Existence", eventually(5,9)).
template("Co Existence", eventually(6,10)).
template("Co Existence", atom(7,arg_0)).
template("Co Existence", atom(8,arg_1)).
template("Co Existence", atom(9,arg_1)).
template("Co Existence", atom(10,arg_0)).

% Response -- G(arg_0 -> F(arg_1))
template("Response", always(0,1)).
template("Response", implies(1,2,3)).
template("Response", atom(2,arg_0)).
template("Response", eventually(3,4)).
template("Response", atom(4,arg_1)).

% Alternate Response -- G(arg_0 -> F(arg_1)) & G(arg_0 -> X(!arg_0 W arg_1))
template("Alternate Response", conjunction(0,1,2)).
template("Alternate Response", always(1,3)).
template("Alternate Response", always(2,4)).
template("Alternate Response", implies(3,5,6)).
template("Alternate Response", implies(4,7,8)).
template("Alternate Response", atom(5,arg_0)).
template("Alternate Response", eventually(6,9)).
template("Alternate Response", atom(7,arg_0)).
template("Alternate Response", next(8,10)).
template("Alternate Response", atom(9,arg_1)).
template("Alternate Response", disjunction(10,11,12)).
template("Alternate Response", until(11,13,14)).
template("Alternate Response", always(12,15)).
template("Alternate Response", negate(13,16)).
template("Alternate Response", atom(14,arg_1)).
template("Alternate Response", negate(15,17)).
template("Alternate Response", atom(16,arg_0)).
template("Alternate Response", atom(17,arg_0)).

% Chain Response -- G(arg_0-> F(arg_1)) & G(arg_0 -> X(arg_1))
template("Chain Response", conjunction(0,1,2)).
template("Chain Response", always(1,3)).
template("Chain Response", always(2,4)).
template("Chain Response", implies(3,5,6)).
template("Chain Response", implies(4,7,8)).
template("Chain Response", atom(5,arg_0)).
template("Chain Response", eventually(6,9)).
template("Chain Response", atom(7,arg_0)).
template("Chain Response", next(8,10)).
template("Chain Response", atom(9,arg_1)).
template("Chain Response", atom(10,arg_1)).

% Precedence -- !arg_1 W arg_0
template("Precedence", disjunction(0,1,2)).
template("Precedence", until(1,3,4)).
template("Precedence", always(2,5)).
template("Precedence", negate(3,6)).
template("Precedence", atom(4,arg_0)).
template("Precedence", negate(5,7)).
template("Precedence", atom(6,arg_1)).
template("Precedence", atom(7,arg_1)).

% Alternate Precedence -- (!arg_1 W arg_0) & G(arg_1 -> X(!arg_1 W arg_0))
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

