% Existence --  F(arg_0)
template("Existence", (eventually,(atom,arg_0))).

% Absence --  ~F(arg_0)
template("Absence", (negate,(eventually,(atom,arg_0)))).

% Init --  arg_0
template("Init", (atom,arg_0)).

% Last --  last
template("Last", (last,)).

% True --  true
template("True", (true,)).

% False --  false
template("False", (false,)).

% Choice --  F(arg_0) | F(arg_1)
template("Choice", (disjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))).

% Exclusive Choice --  (F(arg_0) | F(arg_1)) & ~(F(arg_0) & F(arg_1))
template("Exclusive Choice", (conjunction,(disjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1))),(negate,(conjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))))).

% Responded Existence --  F(arg_0) -> F(arg_1)
template("Responded Existence", (implies,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))).

% Co-Existence --  (F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))
template("Co-Existence", (conjunction,(implies,(eventually,(atom,arg_0)),(eventually,(atom,arg_1))),(implies,(eventually,(atom,arg_1)),(eventually,(atom,arg_0))))).

% Response --  G(arg_0 -> F(arg_1))
template("Response", (always,(implies,(atom,arg_0),(eventually,(atom,arg_1))))).

% Alternate Response --  G(arg_0 -> X(~arg_0 U arg_1))
template("Alternate Response", (always,(implies,(atom,arg_0),(next,(until,(negate,(atom,arg_0)),(atom,arg_1)))))).

% Chain Response --  G(arg_0 -> X(arg_1))
template("Chain Response", (always,(implies,(atom,arg_0),(next,(atom,arg_1))))).

% Not Co-Existence --  (F(arg_0) -> ~F(arg_1)) & (F(arg_1) -> ~F(arg_0))
template("Not Co-Existence", (conjunction,(implies,(eventually,(atom,arg_0)),(negate,(eventually,(atom,arg_1)))),(implies,(eventually,(atom,arg_1)),(negate,(eventually,(atom,arg_0)))))).

% Not Succession --  G(arg_0 -> ~F(arg_1))
template("Not Succession", (always,(implies,(atom,arg_0),(negate,(eventually,(atom,arg_1)))))).

% Not Chain Succession --  G(arg_0 -> ~X(arg_1))
template("Not Chain Succession", (always,(implies,(atom,arg_0),(negate,(next,(atom,arg_1)))))).

% Precedence --  ~arg_1 W arg_0
template("Precedence", (release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1))))).

% Alternate Precedence --  (~arg_1 W arg_0) & G(arg_1 -> (~arg_1 W arg_0))
template("Alternate Precedence", (conjunction,(release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1)))),(always,(implies,(atom,arg_1),(release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1)))))))).

% Chain Precedence --  G(X(arg_1) -> arg_0)
template("Chain Precedence", (always,(implies,(next,(atom,arg_1)),(atom,arg_0)))).

% Succession --  G(arg_0 -> F(arg_1)) & (~arg_1 W arg_0)
template("Succession", (conjunction,(always,(implies,(atom,arg_0),(eventually,(atom,arg_1)))),(release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1)))))).

% Alternate Succession --  G(arg_0 -> X(~arg_0 U arg_1)) & (~arg_1 W arg_0) & G(arg_1 -> (~arg_1 W arg_0))
template("Alternate Succession", (conjunction,(always,(implies,(atom,arg_0),(next,(until,(negate,(atom,arg_0)),(atom,arg_1))))),(release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1)))))).

% Chain Succession --  G(arg_0 -> X(arg_1)) & G(X(arg_1) -> arg_0)
template("Chain Succession", (conjunction,(always,(implies,(atom,arg_0),(next,(atom,arg_1)))),(always,(implies,(next,(atom,arg_1)),(atom,arg_0))))).

