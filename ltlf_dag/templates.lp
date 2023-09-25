% Existence --  F(arg_0)
template("Existence", (eventually,(atom,arg_0))).

% Absence 2 --  !F(arg_0 & XF(arg_0))
template("Absence 2", (negate,(eventually,(conjunction,(atom,arg_0),(next,(eventually,(atom,arg_0))))))).

% Choice --  F(arg_0) | F(arg_1)
template("Choice", (disjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))).

% Exclusive Choice --  (F(arg_0) | F(arg_1)) & !(F(arg_0) & F(arg_1))
template("Exclusive Choice", (conjunction,(disjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1))),(negate,(conjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))))).

% Responded Existence --  F(arg_0) -> F(arg_1)
template("Responded Existence", (implies,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))).

% Coexistence --  F(arg_0) <-> F(arg_1)
template("Coexistence", (equals,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))).

% Response --  G(arg_0 -> F(arg_1))
template("Response", (always,(implies,(atom,arg_0),(eventually,(atom,arg_1))))).

% Precedence --  !arg_1 W arg_0
template("Precedence", (disjunction,(until,(negate,(atom,arg_1)),(atom,arg_0)),(always,(negate,(atom,arg_1))))).

% Succession --  G(arg_0 -> F(arg_1)) & (!arg_1 W arg_0)
template("Succession", (conjunction,(always,(implies,(atom,arg_0),(eventually,(atom,arg_1)))),(disjunction,(until,(negate,(atom,arg_1)),(atom,arg_0)),(always,(negate,(atom,arg_1)))))).

% Alternate Response --  G(arg_0 -> X(!arg_0 U arg_1))
template("Alternate Response", (always,(implies,(atom,arg_0),(next,(until,(negate,(atom,arg_0)),(atom,arg_1)))))).

% Alternate Precedence --  (!arg_1 W arg_0) & G(arg_1 -> WX(!arg_1 W arg_0))
template("Alternate Precedence", (conjunction,(disjunction,(until,(negate,(atom,arg_1)),(atom,arg_0)),(always,(negate,(atom,arg_1)))),(always,(implies,(atom,arg_1),None)))).

% Alternate Succession --  G(arg_0 -> X(!arg_0 U arg_1)) & (!arg_1 W arg_0) & G(arg_1 -> WX(!arg_1 W arg_0))
template("Alternate Succession", (conjunction,(always,(implies,(atom,arg_0),(next,(until,(negate,(atom,arg_0)),(atom,arg_1))))),(disjunction,(until,(negate,(atom,arg_1)),(atom,arg_0)),(always,(negate,(atom,arg_1)))))).

% Chain Response --  G(arg_0 -> X(arg_1))
template("Chain Response", (always,(implies,(atom,arg_0),(next,(atom,arg_1))))).

% Chain Precedence --  G(X(arg_1) -> arg_0)
template("Chain Precedence", (always,(implies,(next,(atom,arg_1)),(atom,arg_0)))).

% Chain Succession --  G(arg_0 <-> X(arg_1))
template("Chain Succession", (always,(equals,(atom,arg_0),(next,(atom,arg_1))))).

% Not Coexistence --  !(F(arg_0) & F(arg_1))
template("Not Coexistence", (negate,(conjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1))))).

% Neg Succession --  G(arg_0 -> !F(arg_1))
template("Neg Succession", (always,(implies,(atom,arg_0),(negate,(eventually,(atom,arg_1)))))).

% Neg Chain Succession --  G(arg_0 <-> X(!arg_1))
template("Neg Chain Succession", (always,(equals,(atom,arg_0),(next,(negate,(atom,arg_1)))))).

