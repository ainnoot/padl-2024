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

% ExclusiveChoice --  (F(arg_0) | F(arg_1)) & ~(F(arg_0) & F(arg_1))
template("ExclusiveChoice", (conjunction,(disjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1))),(negate,(conjunction,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))))).

% RespondedExistence --  F(arg_0) -> F(arg_1)
template("RespondedExistence", (implies,(eventually,(atom,arg_0)),(eventually,(atom,arg_1)))).

% CoExistence --  (F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))
template("CoExistence", (conjunction,(implies,(eventually,(atom,arg_0)),(eventually,(atom,arg_1))),(implies,(eventually,(atom,arg_1)),(eventually,(atom,arg_0))))).

% Response --  G(arg_0 -> F(arg_1))
template("Response", (always,(implies,(atom,arg_0),(eventually,(atom,arg_1))))).

% AlternateResponse --  G(arg_0 -> X(~arg_0 U arg_1))
template("AlternateResponse", (always,(implies,(atom,arg_0),(next,(until,(negate,(atom,arg_0)),(atom,arg_1)))))).

% ChainResponse --  G(arg_0 -> X(arg_1))
template("ChainResponse", (always,(implies,(atom,arg_0),(next,(atom,arg_1))))).

% NotCoExistence --  (F(arg_0) -> ~F(arg_1)) & (F(arg_1) -> ~F(arg_0))
template("NotCoExistence", (conjunction,(implies,(eventually,(atom,arg_0)),(negate,(eventually,(atom,arg_1)))),(implies,(eventually,(atom,arg_1)),(negate,(eventually,(atom,arg_0)))))).

% NotSuccession --  G(arg_0 -> ~F(arg_1))
template("NotSuccession", (always,(implies,(atom,arg_0),(negate,(eventually,(atom,arg_1)))))).

% NotChainSuccession --  G(arg_0 -> ~X(arg_1))
template("NotChainSuccession", (always,(implies,(atom,arg_0),(negate,(next,(atom,arg_1)))))).

% Precedence --  ~arg_1 R arg_0
template("Precedence", (release,(negate,(atom,arg_1)),(atom,arg_0))).

% AlternatePrecedence --  (~arg_1 W arg_0) & G(arg_1 -> (~arg_1 W arg_0))
template("AlternatePrecedence", (conjunction,(release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1)))),(always,(implies,(atom,arg_1),(release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1)))))))).

% ChainPrecedence --  G(X(arg_1) -> arg_0)
template("ChainPrecedence", (always,(implies,(next,(atom,arg_1)),(atom,arg_0)))).

% Succession --  G(arg_0 -> F(arg_1)) & (~arg_1 W arg_0)
template("Succession", (conjunction,(always,(implies,(atom,arg_0),(eventually,(atom,arg_1)))),(release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1)))))).

% AlternateSuccession --  G(arg_0 -> X(~arg_0 U arg_1)) & (~arg_1 W arg_0) & G(arg_1 -> (~arg_1 W arg_0))
template("AlternateSuccession", (conjunction,(always,(implies,(atom,arg_0),(next,(until,(negate,(atom,arg_0)),(atom,arg_1))))),(release,(atom,arg_0),(disjunction,(atom,arg_0),(negate,(atom,arg_1)))))).

% ChainSuccession --  G(arg_0 -> X(arg_1)) & G(X(arg_0) -> arg_1)
template("ChainSuccession", (conjunction,(always,(implies,(atom,arg_0),(next,(atom,arg_1)))),(always,(implies,(next,(atom,arg_0)),(atom,arg_1))))).

