% Existence -- F(arg_0)
template("Existence",0,arg_0,1).
template("Existence",0,__skip__,0).
template("Existence",1,__skip__,1).
template("Existence",1,arg_0,1).
accepting("Existence",1).
initial("Existence",0).

% Absence -- ~F(arg_0)
template("Absence",0,arg_0,1).
template("Absence",0,__skip__,0).
template("Absence",1,__skip__,1).
template("Absence",1,arg_0,1).
accepting("Absence",0).
initial("Absence",0).

% Init -- arg_0
template("Init",0,arg_0,1).
template("Init",0,__skip__,2).
template("Init",1,__skip__,1).
template("Init",1,arg_0,1).
template("Init",2,__skip__,2).
template("Init",2,arg_0,2).
accepting("Init",1).
initial("Init",0).

% Last -- last
template("Last",0,__skip__,1).
template("Last",1,__skip__,2).
template("Last",2,__skip__,2).
accepting("Last",1).
initial("Last",0).

% True -- true
template("True",0,__skip__,1).
template("True",1,__skip__,1).
accepting("True",1).
initial("True",0).

% False -- false
template("False",0,__skip__,0).
initial("False",0).

% Choice -- F(arg_0) | F(arg_1)
template("Choice",0,__skip__,0).
template("Choice",0,arg_1,1).
template("Choice",0,arg_0,1).
template("Choice",1,__skip__,1).
template("Choice",1,arg_1,1).
template("Choice",1,arg_0,1).
accepting("Choice",1).
initial("Choice",0).

% ExclusiveChoice -- (F(arg_0) | F(arg_1)) & ~(F(arg_0) & F(arg_1))
template("ExclusiveChoice",0,__skip__,0).
template("ExclusiveChoice",0,arg_0,2).
template("ExclusiveChoice",0,arg_1,3).
template("ExclusiveChoice",1,__skip__,1).
template("ExclusiveChoice",1,arg_1,1).
template("ExclusiveChoice",1,arg_0,1).
template("ExclusiveChoice",2,arg_1,1).
template("ExclusiveChoice",2,__skip__,2).
template("ExclusiveChoice",2,arg_0,2).
template("ExclusiveChoice",3,arg_0,1).
template("ExclusiveChoice",3,__skip__,3).
template("ExclusiveChoice",3,arg_1,3).
accepting("ExclusiveChoice",2).
accepting("ExclusiveChoice",3).
initial("ExclusiveChoice",0).

% RespondedExistence -- F(arg_0) -> F(arg_1)
template("RespondedExistence",0,__skip__,0).
template("RespondedExistence",0,arg_0,1).
template("RespondedExistence",0,arg_1,2).
template("RespondedExistence",1,arg_1,2).
template("RespondedExistence",1,__skip__,1).
template("RespondedExistence",1,arg_0,1).
template("RespondedExistence",2,__skip__,2).
template("RespondedExistence",2,arg_1,2).
template("RespondedExistence",2,arg_0,2).
accepting("RespondedExistence",0).
accepting("RespondedExistence",2).
initial("RespondedExistence",0).

% CoExistence -- (F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))
template("CoExistence",0,__skip__,0).
template("CoExistence",0,arg_0,3).
template("CoExistence",0,arg_1,2).
template("CoExistence",1,__skip__,1).
template("CoExistence",1,arg_1,1).
template("CoExistence",1,arg_0,1).
template("CoExistence",2,__skip__,2).
template("CoExistence",2,arg_1,2).
template("CoExistence",2,arg_0,1).
template("CoExistence",3,__skip__,3).
template("CoExistence",3,arg_0,3).
template("CoExistence",3,arg_1,1).
accepting("CoExistence",0).
accepting("CoExistence",1).
initial("CoExistence",0).

% Response -- G(arg_0 -> F(arg_1))
template("Response",0,arg_0,1).
template("Response",0,__skip__,0).
template("Response",0,arg_1,0).
template("Response",1,arg_1,0).
template("Response",1,__skip__,1).
template("Response",1,arg_0,1).
accepting("Response",0).
initial("Response",0).

% AlternateResponse -- G(arg_0 -> X(~arg_0 U arg_1))
template("AlternateResponse",0,arg_0,1).
template("AlternateResponse",0,__skip__,0).
template("AlternateResponse",0,arg_1,0).
template("AlternateResponse",1,arg_0,2).
template("AlternateResponse",1,arg_1,0).
template("AlternateResponse",1,__skip__,1).
template("AlternateResponse",2,__skip__,2).
template("AlternateResponse",2,arg_1,2).
template("AlternateResponse",2,arg_0,2).
accepting("AlternateResponse",0).
initial("AlternateResponse",0).

% ChainResponse -- G(arg_0 -> X(arg_1))
template("ChainResponse",0,arg_0,1).
template("ChainResponse",0,__skip__,0).
template("ChainResponse",0,arg_1,0).
template("ChainResponse",1,arg_1,0).
template("ChainResponse",1,__skip__,2).
template("ChainResponse",1,arg_0,2).
template("ChainResponse",2,__skip__,2).
template("ChainResponse",2,arg_1,2).
template("ChainResponse",2,arg_0,2).
accepting("ChainResponse",0).
initial("ChainResponse",0).

% NotCoExistence -- (F(arg_0) -> ~F(arg_1)) & (F(arg_1) -> ~F(arg_0))
template("NotCoExistence",0,__skip__,0).
template("NotCoExistence",0,arg_1,1).
template("NotCoExistence",0,arg_0,3).
template("NotCoExistence",1,__skip__,1).
template("NotCoExistence",1,arg_1,1).
template("NotCoExistence",1,arg_0,2).
template("NotCoExistence",2,__skip__,2).
template("NotCoExistence",2,arg_1,2).
template("NotCoExistence",2,arg_0,2).
template("NotCoExistence",3,__skip__,3).
template("NotCoExistence",3,arg_0,3).
template("NotCoExistence",3,arg_1,2).
accepting("NotCoExistence",0).
accepting("NotCoExistence",1).
accepting("NotCoExistence",3).
initial("NotCoExistence",0).

% NotSuccession -- G(arg_0 -> ~F(arg_1))
template("NotSuccession",0,arg_0,1).
template("NotSuccession",0,__skip__,0).
template("NotSuccession",0,arg_1,0).
template("NotSuccession",1,arg_1,2).
template("NotSuccession",1,__skip__,1).
template("NotSuccession",1,arg_0,1).
template("NotSuccession",2,__skip__,2).
template("NotSuccession",2,arg_1,2).
template("NotSuccession",2,arg_0,2).
accepting("NotSuccession",0).
accepting("NotSuccession",1).
initial("NotSuccession",0).

% NotChainSuccession -- G(arg_0 -> ~X(arg_1))
template("NotChainSuccession",0,arg_0,2).
template("NotChainSuccession",0,__skip__,0).
template("NotChainSuccession",0,arg_1,0).
template("NotChainSuccession",1,__skip__,1).
template("NotChainSuccession",1,arg_1,1).
template("NotChainSuccession",1,arg_0,1).
template("NotChainSuccession",2,arg_1,1).
template("NotChainSuccession",2,__skip__,0).
template("NotChainSuccession",2,arg_0,2).
accepting("NotChainSuccession",0).
accepting("NotChainSuccession",2).
initial("NotChainSuccession",0).

% Precedence -- ~arg_1 R arg_0
template("Precedence",0,arg_0,1).
template("Precedence",0,__skip__,2).
template("Precedence",0,arg_1,2).
template("Precedence",1,__skip__,1).
template("Precedence",1,arg_1,1).
template("Precedence",1,arg_0,1).
template("Precedence",2,__skip__,2).
template("Precedence",2,arg_1,2).
template("Precedence",2,arg_0,2).
accepting("Precedence",0).
accepting("Precedence",1).
initial("Precedence",0).

% AlternatePrecedence -- (~arg_1 W arg_0) & G(arg_1 -> (~arg_1 W arg_0))
template("AlternatePrecedence",0,__skip__,0).
template("AlternatePrecedence",0,arg_0,0).
template("AlternatePrecedence",0,arg_1,1).
template("AlternatePrecedence",1,__skip__,1).
template("AlternatePrecedence",1,arg_1,1).
template("AlternatePrecedence",1,arg_0,1).
accepting("AlternatePrecedence",0).
initial("AlternatePrecedence",0).

% ChainPrecedence -- G(X(arg_1) -> arg_0)
template("ChainPrecedence",0,__skip__,1).
template("ChainPrecedence",0,arg_1,1).
template("ChainPrecedence",0,arg_0,0).
template("ChainPrecedence",1,arg_1,2).
template("ChainPrecedence",1,arg_0,0).
template("ChainPrecedence",1,__skip__,1).
template("ChainPrecedence",2,__skip__,2).
template("ChainPrecedence",2,arg_1,2).
template("ChainPrecedence",2,arg_0,2).
accepting("ChainPrecedence",0).
accepting("ChainPrecedence",1).
initial("ChainPrecedence",0).

% Succession -- G(arg_0 -> F(arg_1)) & (~arg_1 W arg_0)
template("Succession",0,__skip__,0).
template("Succession",0,arg_1,1).
template("Succession",0,arg_0,2).
template("Succession",1,__skip__,1).
template("Succession",1,arg_1,1).
template("Succession",1,arg_0,1).
template("Succession",2,__skip__,2).
template("Succession",2,arg_0,2).
template("Succession",2,arg_1,3).
template("Succession",3,arg_0,2).
template("Succession",3,__skip__,3).
template("Succession",3,arg_1,3).
accepting("Succession",0).
accepting("Succession",3).
initial("Succession",0).

% AlternateSuccession -- G(arg_0 -> X(~arg_0 U arg_1)) & (~arg_1 W arg_0) & G(arg_1 -> (~arg_1 W arg_0))
template("AlternateSuccession",0,__skip__,0).
template("AlternateSuccession",0,arg_1,1).
template("AlternateSuccession",0,arg_0,1).
template("AlternateSuccession",1,__skip__,1).
template("AlternateSuccession",1,arg_1,1).
template("AlternateSuccession",1,arg_0,1).
accepting("AlternateSuccession",0).
initial("AlternateSuccession",0).

% ChainSuccession -- G(arg_0 -> X(arg_1)) & G(X(arg_0) -> arg_1)
template("ChainSuccession",0,arg_0,1).
template("ChainSuccession",0,arg_1,0).
template("ChainSuccession",0,__skip__,3).
template("ChainSuccession",1,arg_1,0).
template("ChainSuccession",1,__skip__,2).
template("ChainSuccession",1,arg_0,2).
template("ChainSuccession",2,__skip__,2).
template("ChainSuccession",2,arg_1,2).
template("ChainSuccession",2,arg_0,2).
template("ChainSuccession",3,__skip__,3).
template("ChainSuccession",3,arg_1,0).
template("ChainSuccession",3,arg_0,2).
template("ChainSuccession",4,__skip__,2).
template("ChainSuccession",4,arg_0,2).
template("ChainSuccession",4,arg_1,0).
accepting("ChainSuccession",0).
accepting("ChainSuccession",3).
initial("ChainSuccession",0).

