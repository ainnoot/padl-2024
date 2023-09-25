% Existence -- F(arg_0)
template("Existence",0,arg_0,1).
template("Existence",0,__skip__,0).
template("Existence",1,arg_0,1).
template("Existence",1,__skip__,1).
accepting("Existence",1).
initial("Existence",0).

% Absence 2 -- !F(arg_0 & XF(arg_0))
template("Absence 2",0,arg_0,1).
template("Absence 2",0,__skip__,0).
template("Absence 2",1,__skip__,1).
template("Absence 2",1,arg_0,2).
template("Absence 2",2,arg_0,2).
template("Absence 2",2,__skip__,2).
accepting("Absence 2",0).
accepting("Absence 2",1).
initial("Absence 2",0).

% Choice -- F(arg_0) | F(arg_1)
template("Choice",0,__skip__,0).
template("Choice",0,arg_0,1).
template("Choice",0,arg_1,1).
template("Choice",1,arg_0,1).
template("Choice",1,__skip__,1).
template("Choice",1,arg_1,1).
accepting("Choice",1).
initial("Choice",0).

% Exclusive Choice -- (F(arg_0) | F(arg_1)) & !(F(arg_0) & F(arg_1))
template("Exclusive Choice",0,__skip__,0).
template("Exclusive Choice",0,arg_1,3).
template("Exclusive Choice",0,arg_0,1).
template("Exclusive Choice",1,arg_1,2).
template("Exclusive Choice",1,arg_0,1).
template("Exclusive Choice",1,__skip__,1).
template("Exclusive Choice",2,arg_0,2).
template("Exclusive Choice",2,__skip__,2).
template("Exclusive Choice",2,arg_1,2).
template("Exclusive Choice",3,arg_0,2).
template("Exclusive Choice",3,__skip__,3).
template("Exclusive Choice",3,arg_1,3).
accepting("Exclusive Choice",1).
accepting("Exclusive Choice",3).
initial("Exclusive Choice",0).

% Responded Existence -- F(arg_0) -> F(arg_1)
template("Responded Existence",0,__skip__,0).
template("Responded Existence",0,arg_1,1).
template("Responded Existence",0,arg_0,2).
template("Responded Existence",1,arg_0,1).
template("Responded Existence",1,__skip__,1).
template("Responded Existence",1,arg_1,1).
template("Responded Existence",2,arg_0,2).
template("Responded Existence",2,__skip__,2).
template("Responded Existence",2,arg_1,1).
accepting("Responded Existence",0).
accepting("Responded Existence",1).
initial("Responded Existence",0).

% Coexistence -- F(arg_0) <-> F(arg_1)
template("Coexistence",0,__skip__,0).
template("Coexistence",0,arg_1,1).
template("Coexistence",0,arg_0,2).
template("Coexistence",1,arg_0,3).
template("Coexistence",1,__skip__,1).
template("Coexistence",1,arg_1,1).
template("Coexistence",2,arg_1,3).
template("Coexistence",2,arg_0,2).
template("Coexistence",2,__skip__,2).
template("Coexistence",3,arg_0,3).
template("Coexistence",3,__skip__,3).
template("Coexistence",3,arg_1,3).
accepting("Coexistence",0).
accepting("Coexistence",3).
initial("Coexistence",0).

% Response -- G(arg_0 -> F(arg_1))
template("Response",0,__skip__,0).
template("Response",0,arg_1,0).
template("Response",0,arg_0,1).
template("Response",1,arg_0,1).
template("Response",1,__skip__,1).
template("Response",1,arg_1,0).
accepting("Response",0).
initial("Response",0).

% Precedence -- !arg_1 W arg_0
template("Precedence",0,__skip__,0).
template("Precedence",0,arg_0,2).
template("Precedence",0,arg_1,1).
template("Precedence",1,arg_0,1).
template("Precedence",1,__skip__,1).
template("Precedence",1,arg_1,1).
template("Precedence",2,arg_0,2).
template("Precedence",2,__skip__,2).
template("Precedence",2,arg_1,2).
accepting("Precedence",0).
accepting("Precedence",2).
initial("Precedence",0).

% Succession -- G(arg_0 -> F(arg_1)) & (!arg_1 W arg_0)
template("Succession",0,__skip__,0).
template("Succession",0,arg_1,3).
template("Succession",0,arg_0,1).
template("Succession",1,arg_1,2).
template("Succession",1,arg_0,1).
template("Succession",1,__skip__,1).
template("Succession",2,arg_0,1).
template("Succession",2,__skip__,2).
template("Succession",2,arg_1,2).
template("Succession",3,arg_0,3).
template("Succession",3,__skip__,3).
template("Succession",3,arg_1,3).
accepting("Succession",0).
accepting("Succession",2).
initial("Succession",0).

% Alternate Response -- G(arg_0 -> X(!arg_0 U arg_1))
template("Alternate Response",0,arg_0,1).
template("Alternate Response",0,__skip__,0).
template("Alternate Response",0,arg_1,0).
template("Alternate Response",1,__skip__,1).
template("Alternate Response",1,arg_0,2).
template("Alternate Response",1,arg_1,0).
template("Alternate Response",2,arg_0,2).
template("Alternate Response",2,__skip__,2).
template("Alternate Response",2,arg_1,2).
accepting("Alternate Response",0).
initial("Alternate Response",0).

% Alternate Precedence -- (!arg_1 W arg_0) & G(arg_1 -> WX(!arg_1 W arg_0))
template("Alternate Precedence",0,__skip__,0).
template("Alternate Precedence",0,arg_1,2).
template("Alternate Precedence",0,arg_0,1).
template("Alternate Precedence",1,arg_0,1).
template("Alternate Precedence",1,__skip__,1).
template("Alternate Precedence",1,arg_1,0).
template("Alternate Precedence",2,arg_0,2).
template("Alternate Precedence",2,__skip__,2).
template("Alternate Precedence",2,arg_1,2).
accepting("Alternate Precedence",0).
accepting("Alternate Precedence",1).
initial("Alternate Precedence",0).

% Alternate Succession -- G(arg_0 -> X(!arg_0 U arg_1)) & (!arg_1 W arg_0) & G(arg_1 -> WX(!arg_1 W arg_0))
template("Alternate Succession",0,__skip__,0).
template("Alternate Succession",0,arg_1,1).
template("Alternate Succession",0,arg_0,2).
template("Alternate Succession",1,arg_0,1).
template("Alternate Succession",1,__skip__,1).
template("Alternate Succession",1,arg_1,1).
template("Alternate Succession",2,arg_0,1).
template("Alternate Succession",2,arg_1,0).
template("Alternate Succession",2,__skip__,2).
accepting("Alternate Succession",0).
initial("Alternate Succession",0).

% Chain Response -- G(arg_0 -> X(arg_1))
template("Chain Response",0,arg_0,1).
template("Chain Response",0,__skip__,0).
template("Chain Response",0,arg_1,0).
template("Chain Response",1,arg_0,2).
template("Chain Response",1,__skip__,2).
template("Chain Response",1,arg_1,0).
template("Chain Response",2,arg_0,2).
template("Chain Response",2,__skip__,2).
template("Chain Response",2,arg_1,2).
accepting("Chain Response",0).
initial("Chain Response",0).

% Chain Precedence -- G(X(arg_1) -> arg_0)
template("Chain Precedence",0,arg_0,0).
template("Chain Precedence",0,__skip__,2).
template("Chain Precedence",0,arg_1,2).
template("Chain Precedence",1,arg_0,1).
template("Chain Precedence",1,__skip__,1).
template("Chain Precedence",1,arg_1,1).
template("Chain Precedence",2,arg_0,0).
template("Chain Precedence",2,arg_1,1).
template("Chain Precedence",2,__skip__,2).
accepting("Chain Precedence",0).
accepting("Chain Precedence",2).
initial("Chain Precedence",0).

% Chain Succession -- G(arg_0 <-> X(arg_1))
template("Chain Succession",0,arg_0,1).
template("Chain Succession",0,__skip__,2).
template("Chain Succession",0,arg_1,2).
template("Chain Succession",1,arg_1,2).
template("Chain Succession",1,arg_0,3).
template("Chain Succession",1,__skip__,3).
template("Chain Succession",2,arg_1,3).
template("Chain Succession",2,arg_0,1).
template("Chain Succession",2,__skip__,2).
template("Chain Succession",3,arg_0,3).
template("Chain Succession",3,__skip__,3).
template("Chain Succession",3,arg_1,3).
accepting("Chain Succession",0).
accepting("Chain Succession",2).
initial("Chain Succession",0).

% Not Coexistence -- !(F(arg_0) & F(arg_1))
template("Not Coexistence",0,__skip__,0).
template("Not Coexistence",0,arg_0,3).
template("Not Coexistence",0,arg_1,1).
template("Not Coexistence",1,__skip__,1).
template("Not Coexistence",1,arg_1,1).
template("Not Coexistence",1,arg_0,2).
template("Not Coexistence",2,arg_0,2).
template("Not Coexistence",2,__skip__,2).
template("Not Coexistence",2,arg_1,2).
template("Not Coexistence",3,arg_1,2).
template("Not Coexistence",3,arg_0,3).
template("Not Coexistence",3,__skip__,3).
accepting("Not Coexistence",0).
accepting("Not Coexistence",1).
accepting("Not Coexistence",3).
initial("Not Coexistence",0).

% Neg Succession -- G(arg_0 -> !F(arg_1))
template("Neg Succession",0,__skip__,0).
template("Neg Succession",0,arg_1,0).
template("Neg Succession",0,arg_0,1).
template("Neg Succession",1,arg_0,1).
template("Neg Succession",1,__skip__,1).
template("Neg Succession",1,arg_1,2).
template("Neg Succession",2,arg_0,2).
template("Neg Succession",2,__skip__,2).
template("Neg Succession",2,arg_1,2).
accepting("Neg Succession",0).
accepting("Neg Succession",1).
initial("Neg Succession",0).

% Neg Chain Succession -- G(arg_0 <-> X(!arg_1))
template("Neg Chain Succession",0,arg_0,1).
template("Neg Chain Succession",0,__skip__,2).
template("Neg Chain Succession",0,arg_1,2).
template("Neg Chain Succession",1,__skip__,2).
template("Neg Chain Succession",1,arg_1,3).
template("Neg Chain Succession",1,arg_0,1).
template("Neg Chain Succession",2,arg_1,2).
template("Neg Chain Succession",2,arg_0,3).
template("Neg Chain Succession",2,__skip__,3).
template("Neg Chain Succession",3,arg_0,3).
template("Neg Chain Succession",3,__skip__,3).
template("Neg Chain Succession",3,arg_1,3).
accepting("Neg Chain Succession",0).
accepting("Neg Chain Succession",2).
initial("Neg Chain Succession",0).

