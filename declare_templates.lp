% Existence -- F(arg_0)
template("Existence", eventually(0,1)).
template("Existence", atom(1,arg_0)).

% Absence -- ~F(arg_0)
template("Absence", negate(0,1)).
template("Absence", eventually(1,2)).
template("Absence", atom(2,arg_0)).

% Init -- arg_0
template("Init", atom(0,arg_0)).

% Last -- last
template("Last", last(0)).

% True -- true
template("True", true(0)).

% False -- false
template("False", false(0)).

% Choice -- F(arg_0) | F(arg_1)
template("Choice", disjunction(0,1,2)).
template("Choice", eventually(1,3)).
template("Choice", eventually(2,4)).
template("Choice", atom(3,arg_0)).
template("Choice", atom(4,arg_1)).

% ExclusiveChoice -- (F(arg_0) | F(arg_1)) & ~(F(arg_0) & F(arg_1))
template("ExclusiveChoice", conjunction(0,1,2)).
template("ExclusiveChoice", disjunction(1,3,4)).
template("ExclusiveChoice", negate(2,5)).
template("ExclusiveChoice", eventually(3,6)).
template("ExclusiveChoice", eventually(4,7)).
template("ExclusiveChoice", conjunction(5,8,9)).
template("ExclusiveChoice", atom(6,arg_0)).
template("ExclusiveChoice", atom(7,arg_1)).
template("ExclusiveChoice", eventually(8,10)).
template("ExclusiveChoice", eventually(9,11)).
template("ExclusiveChoice", atom(10,arg_0)).
template("ExclusiveChoice", atom(11,arg_1)).

% RespondedExistence -- F(arg_0) -> F(arg_1)
template("RespondedExistence", implies(0,1,2)).
template("RespondedExistence", eventually(1,3)).
template("RespondedExistence", eventually(2,4)).
template("RespondedExistence", atom(3,arg_0)).
template("RespondedExistence", atom(4,arg_1)).

% CoExistence -- (F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))
template("CoExistence", conjunction(0,1,2)).
template("CoExistence", implies(1,3,4)).
template("CoExistence", implies(2,5,6)).
template("CoExistence", eventually(3,7)).
template("CoExistence", eventually(4,8)).
template("CoExistence", eventually(5,9)).
template("CoExistence", eventually(6,10)).
template("CoExistence", atom(7,arg_0)).
template("CoExistence", atom(8,arg_1)).
template("CoExistence", atom(9,arg_1)).
template("CoExistence", atom(10,arg_0)).

% Response -- G(arg_0 -> F(arg_1))
template("Response", always(0,1)).
template("Response", implies(1,2,3)).
template("Response", atom(2,arg_0)).
template("Response", eventually(3,4)).
template("Response", atom(4,arg_1)).

% AlternateResponse -- G(arg_0 -> X(~arg_0 U arg_1))
template("AlternateResponse", always(0,1)).
template("AlternateResponse", implies(1,2,3)).
template("AlternateResponse", atom(2,arg_0)).
template("AlternateResponse", next(3,4)).
template("AlternateResponse", until(4,5,6)).
template("AlternateResponse", negate(5,7)).
template("AlternateResponse", atom(6,arg_1)).
template("AlternateResponse", atom(7,arg_0)).

% ChainResponse -- G(arg_0 -> X(arg_1))
template("ChainResponse", always(0,1)).
template("ChainResponse", implies(1,2,3)).
template("ChainResponse", atom(2,arg_0)).
template("ChainResponse", next(3,4)).
template("ChainResponse", atom(4,arg_1)).

% NotCoExistence -- (F(arg_0) -> ~F(arg_1)) & (F(arg_1) -> ~F(arg_0))
template("NotCoExistence", conjunction(0,1,2)).
template("NotCoExistence", implies(1,3,4)).
template("NotCoExistence", implies(2,5,6)).
template("NotCoExistence", eventually(3,7)).
template("NotCoExistence", negate(4,8)).
template("NotCoExistence", eventually(5,9)).
template("NotCoExistence", negate(6,10)).
template("NotCoExistence", atom(7,arg_0)).
template("NotCoExistence", eventually(8,11)).
template("NotCoExistence", atom(9,arg_1)).
template("NotCoExistence", eventually(10,12)).
template("NotCoExistence", atom(11,arg_1)).
template("NotCoExistence", atom(12,arg_0)).

% NotSuccession -- G(arg_0 -> ~F(arg_1))
template("NotSuccession", always(0,1)).
template("NotSuccession", implies(1,2,3)).
template("NotSuccession", atom(2,arg_0)).
template("NotSuccession", negate(3,4)).
template("NotSuccession", eventually(4,5)).
template("NotSuccession", atom(5,arg_1)).

% NotChainSuccession -- G(arg_0 -> ~X(arg_1))
template("NotChainSuccession", always(0,1)).
template("NotChainSuccession", implies(1,2,3)).
template("NotChainSuccession", atom(2,arg_0)).
template("NotChainSuccession", negate(3,4)).
template("NotChainSuccession", next(4,5)).
template("NotChainSuccession", atom(5,arg_1)).

% Precedence -- ~arg_1 R arg_0
template("Precedence", relase(0,1,2)).
template("Precedence", negate(1,3)).
template("Precedence", atom(2,arg_0)).
template("Precedence", atom(3,arg_1)).

% AlternatePrecedence -- (~arg_1 R arg_0) & G(arg_1 -> (~arg_1 R arg_0))
template("AlternatePrecedence", conjunction(0,1,2)).
template("AlternatePrecedence", relase(1,3,4)).
template("AlternatePrecedence", always(2,5)).
template("AlternatePrecedence", negate(3,6)).
template("AlternatePrecedence", atom(4,arg_0)).
template("AlternatePrecedence", implies(5,7,8)).
template("AlternatePrecedence", atom(6,arg_1)).
template("AlternatePrecedence", atom(7,arg_1)).
template("AlternatePrecedence", relase(8,9,10)).
template("AlternatePrecedence", negate(9,11)).
template("AlternatePrecedence", atom(10,arg_0)).
template("AlternatePrecedence", atom(11,arg_1)).

% ChainPrecedence -- G(X(arg_1) -> arg_0)
template("ChainPrecedence", always(0,1)).
template("ChainPrecedence", implies(1,2,3)).
template("ChainPrecedence", next(2,4)).
template("ChainPrecedence", atom(3,arg_0)).
template("ChainPrecedence", atom(4,arg_1)).

% Succession -- G(arg_0 -> F(arg_1)) & (~arg_1 R arg_0)
template("Succession", conjunction(0,1,2)).
template("Succession", always(1,3)).
template("Succession", relase(2,4,5)).
template("Succession", implies(3,6,7)).
template("Succession", negate(4,8)).
template("Succession", atom(5,arg_0)).
template("Succession", atom(6,arg_0)).
template("Succession", eventually(7,9)).
template("Succession", atom(8,arg_1)).
template("Succession", atom(9,arg_1)).

% AlternateSuccession -- G(arg_0 -> X(~arg_0 U arg_1)) & (~arg_1 R arg_0) & G(arg_1 -> (~arg_1 R arg_0))
template("AlternateSuccession", conjunction(0,1,2)).
template("AlternateSuccession", always(1,3)).
template("AlternateSuccession", relase(2,4,5)).
template("AlternateSuccession", implies(3,6,7)).
template("AlternateSuccession", negate(4,8)).
template("AlternateSuccession", atom(5,arg_0)).
template("AlternateSuccession", atom(6,arg_0)).
template("AlternateSuccession", next(7,9)).
template("AlternateSuccession", atom(8,arg_1)).
template("AlternateSuccession", until(9,10,11)).
template("AlternateSuccession", negate(10,12)).
template("AlternateSuccession", atom(11,arg_1)).
template("AlternateSuccession", atom(12,arg_0)).

% ChainSuccession -- G(arg_0 -> X(arg_1)) & G(X(arg_0) -> arg_1)
template("ChainSuccession", conjunction(0,1,2)).
template("ChainSuccession", always(1,3)).
template("ChainSuccession", always(2,4)).
template("ChainSuccession", implies(3,5,6)).
template("ChainSuccession", implies(4,7,8)).
template("ChainSuccession", atom(5,arg_0)).
template("ChainSuccession", next(6,9)).
template("ChainSuccession", next(7,10)).
template("ChainSuccession", atom(8,arg_1)).
template("ChainSuccession", atom(9,arg_1)).
template("ChainSuccession", atom(10,arg_0)).

