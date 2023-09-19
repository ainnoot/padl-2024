% Responded Existence -- F(arg_0) -> F(arg_1)
template("Responded Existence",0,__skip__,0).
template("Responded Existence",0,arg_1,2).
template("Responded Existence",0,arg_0,1).
template("Responded Existence",1,arg_1,2).
template("Responded Existence",1,__skip__,1).
template("Responded Existence",1,arg_0,1).
template("Responded Existence",2,__skip__,2).
template("Responded Existence",2,arg_0,2).
template("Responded Existence",2,arg_1,2).
accepting("Responded Existence",0).
accepting("Responded Existence",2).
initial("Responded Existence",0).

% Co Existence -- (F(arg_0) -> F(arg_1)) & (F(arg_1) -> F(arg_0))
template("Co Existence",0,__skip__,0).
template("Co Existence",0,arg_0,3).
template("Co Existence",0,arg_1,2).
template("Co Existence",1,__skip__,1).
template("Co Existence",1,arg_0,1).
template("Co Existence",1,arg_1,1).
template("Co Existence",2,__skip__,2).
template("Co Existence",2,arg_1,2).
template("Co Existence",2,arg_0,1).
template("Co Existence",3,__skip__,3).
template("Co Existence",3,arg_0,3).
template("Co Existence",3,arg_1,1).
accepting("Co Existence",0).
accepting("Co Existence",1).
initial("Co Existence",0).

% Response -- G(arg_0 -> F(arg_1))
template("Response",0,__skip__,0).
template("Response",0,arg_1,0).
template("Response",0,arg_0,1).
template("Response",1,arg_1,0).
template("Response",1,__skip__,1).
template("Response",1,arg_0,1).
accepting("Response",0).
initial("Response",0).

% Alternate Response -- G(arg_0 -> F(arg_1)) & G(arg_0 -> X(!arg_0 W arg_1))
template("Alternate Response",0,__skip__,0).
template("Alternate Response",0,arg_1,0).
template("Alternate Response",0,arg_0,1).
template("Alternate Response",1,arg_0,3).
template("Alternate Response",1,__skip__,1).
template("Alternate Response",1,arg_1,0).
template("Alternate Response",2,__skip__,2).
template("Alternate Response",2,arg_1,0).
template("Alternate Response",2,arg_0,3).
template("Alternate Response",3,__skip__,3).
template("Alternate Response",3,arg_0,3).
template("Alternate Response",3,arg_1,3).
template("Alternate Response",4,__skip__,2).
template("Alternate Response",4,arg_1,0).
template("Alternate Response",4,arg_0,3).
accepting("Alternate Response",0).
accepting("Alternate Response",2).
initial("Alternate Response",0).

% Chain Response -- G(arg_0-> F(arg_1)) & G(arg_0 -> X(arg_1))
template("Chain Response",0,arg_0,2).
template("Chain Response",0,__skip__,0).
template("Chain Response",0,arg_1,0).
template("Chain Response",1,__skip__,1).
template("Chain Response",1,arg_0,1).
template("Chain Response",1,arg_1,1).
template("Chain Response",2,arg_1,0).
template("Chain Response",2,__skip__,1).
template("Chain Response",2,arg_0,1).
accepting("Chain Response",0).
initial("Chain Response",0).

% Precedence -- !arg_1 W arg_0
template("Precedence",0,arg_1,1).
template("Precedence",0,__skip__,0).
template("Precedence",0,arg_0,2).
template("Precedence",1,__skip__,1).
template("Precedence",1,arg_0,1).
template("Precedence",1,arg_1,1).
template("Precedence",2,__skip__,2).
template("Precedence",2,arg_0,2).
template("Precedence",2,arg_1,2).
accepting("Precedence",0).
accepting("Precedence",2).
initial("Precedence",0).

% Alternate Precedence -- (!arg_1 W arg_0) & G(arg_1 -> X(!arg_1 W arg_0))
template("Alternate Precedence",0,__skip__,0).
template("Alternate Precedence",0,arg_1,1).
template("Alternate Precedence",0,arg_0,2).
template("Alternate Precedence",1,__skip__,1).
template("Alternate Precedence",1,arg_0,1).
template("Alternate Precedence",1,arg_1,1).
template("Alternate Precedence",2,arg_1,3).
template("Alternate Precedence",2,__skip__,2).
template("Alternate Precedence",2,arg_0,2).
template("Alternate Precedence",3,arg_1,1).
template("Alternate Precedence",3,__skip__,0).
template("Alternate Precedence",3,arg_0,2).
accepting("Alternate Precedence",0).
accepting("Alternate Precedence",2).
initial("Alternate Precedence",0).

% Chain Precedence -- (!arg_1 W arg_0) & G(X(arg_1) -> arg_0)
template("Chain Precedence",0,arg_1,1).
template("Chain Precedence",0,arg_0,3).
template("Chain Precedence",0,__skip__,2).
template("Chain Precedence",1,__skip__,1).
template("Chain Precedence",1,arg_0,1).
template("Chain Precedence",1,arg_1,1).
template("Chain Precedence",2,__skip__,2).
template("Chain Precedence",2,arg_1,1).
template("Chain Precedence",2,arg_0,3).
template("Chain Precedence",3,arg_0,3).
template("Chain Precedence",3,__skip__,2).
template("Chain Precedence",3,arg_1,2).
accepting("Chain Precedence",0).
accepting("Chain Precedence",2).
accepting("Chain Precedence",3).
initial("Chain Precedence",0).

