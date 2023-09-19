% Responded Existence --  F(arg_0) -> F(arg_1)
template("Responded Existence", (implies,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))).

% Co Existence --  (F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))
template("Co Existence", (conjunction,(implies,(eventually,(atom,arg_0)),(eventually,(atom,arg_1))),(implies,(eventually,(atom,arg_1)),(eventually,(atom,arg_0))))).

% Response --  G(arg_0 -> F(arg_1))
template("Response", (always,(implies,(atom,arg_0),(eventually,(atom,arg_1))))).

% Alternate Response --  G(arg_0 -> F(arg_1)) & G(arg_0 -> X(!arg_0 W arg_1))
template("Alternate Response", (conjunction,(always,(implies,(atom,arg_0),(eventually,(atom,arg_1)))),(always,(implies,(atom,arg_0),(next,(disjunction,(until,(negate,(atom,arg_0)),(atom,arg_1)),(always,(negate,(atom,arg_0))))))))).

% Chain Response --  G(arg_0-> F(arg_1)) & G(arg_0 -> X(arg_1))
template("Chain Response", (conjunction,(always,(implies,(atom,arg_0),(eventually,(atom,arg_1)))),(always,(implies,(atom,arg_0),(next,(atom,arg_1)))))).

% Precedence --  !arg_1 W arg_0
template("Precedence", (disjunction,(until,(negate,(atom,arg_1)),(atom,arg_0)),(always,(negate,(atom,arg_1))))).

% Alternate Precedence --  (!arg_1 W arg_0) & G(arg_1 -> X(!arg_1 W arg_0))
template("Alternate Precedence", (conjunction,(disjunction,(until,(negate,(atom,arg_1)),(atom,arg_0)),(always,(negate,(atom,arg_1)))),(always,(implies,(atom,arg_1),(next,(disjunction,(until,(negate,(atom,arg_1)),(atom,arg_0)),(always,(negate,(atom,arg_1))))))))).

% Chain Precedence --  (!arg_1 W arg_0) & G(X(arg_1) -> arg_0)
template("Chain Precedence", (conjunction,(disjunction,(until,(negate,(atom,arg_1)),(atom,arg_0)),(always,(negate,(atom,arg_1)))),(always,(implies,(next,(atom,arg_1)),(atom,arg_0))))).

