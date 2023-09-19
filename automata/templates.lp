template("Responded Existence",s_0,arg_1,s_1).
template("Responded Existence",s_1,arg_0,s_1).
template("Responded Existence",s_2,arg_0,s_2).
template("Responded Existence",s_2,__skip__,s_2).
template("Responded Existence",s_0,__skip__,s_0).
template("Responded Existence",s_0,arg_0,s_2).
template("Responded Existence",s_2,arg_1,s_1).
template("Responded Existence",s_1,arg_1,s_1).
template("Responded Existence",s_1,__skip__,s_1).

initial("Responded Existence",s_0).

accepting("Responded Existence",s_0).
accepting("Responded Existence",s_1).


template("Chain Response",s_1,arg_0,s_2).
template("Chain Response",s_0,arg_0,s_1).
template("Chain Response",s_1,arg_1,s_0).
template("Chain Response",s_2,arg_1,s_2).
template("Chain Response",s_0,arg_1,s_0).
template("Chain Response",s_2,arg_0,s_2).
template("Chain Response",s_2,__skip__,s_2).
template("Chain Response",s_0,__skip__,s_0).
template("Chain Response",s_1,__skip__,s_2).

initial("Chain Response",s_0).

accepting("Chain Response",s_0).


template("Not Response",s_0,arg_1,s_0).
template("Not Response",s_1,arg_0,s_1).
template("Not Response",s_2,arg_0,s_2).
template("Not Response",s_2,__skip__,s_2).
template("Not Response",s_0,__skip__,s_0).
template("Not Response",s_0,arg_0,s_2).
template("Not Response",s_2,arg_1,s_1).
template("Not Response",s_1,arg_1,s_1).
template("Not Response",s_1,__skip__,s_1).

initial("Not Response",s_0).

accepting("Not Response",s_0).
accepting("Not Response",s_2).


template("Alternate Response",s_1,arg_0,s_2).
template("Alternate Response",s_0,arg_0,s_1).
template("Alternate Response",s_1,arg_1,s_0).
template("Alternate Response",s_2,arg_1,s_2).
template("Alternate Response",s_0,arg_1,s_0).
template("Alternate Response",s_2,arg_0,s_2).
template("Alternate Response",s_2,__skip__,s_2).
template("Alternate Response",s_0,__skip__,s_0).
template("Alternate Response",s_1,__skip__,s_1).

initial("Alternate Response",s_0).

accepting("Alternate Response",s_0).


template("Existence",s_1,arg_0,s_1).
template("Existence",s_0,arg_0,s_1).
template("Existence",s_1,__skip__,s_1).
template("Existence",s_0,__skip__,s_0).

initial("Existence",s_0).

accepting("Existence",s_1).


template("Exactly1",s_1,arg_0,s_2).
template("Exactly1",s_0,arg_0,s_1).
template("Exactly1",s_2,arg_0,s_2).
template("Exactly1",s_2,__skip__,s_2).
template("Exactly1",s_0,__skip__,s_0).
template("Exactly1",s_1,__skip__,s_1).

initial("Exactly1",s_0).

accepting("Exactly1",s_1).


template("Absence2",s_1,arg_0,s_1).
template("Absence2",s_2,__skip__,s_2).
template("Absence2",s_0,__skip__,s_0).
template("Absence2",s_2,arg_0,s_1).
template("Absence2",s_0,arg_0,s_2).
template("Absence2",s_1,__skip__,s_1).

initial("Absence2",s_0).

accepting("Absence2",s_0).
accepting("Absence2",s_2).


template("Not Chain Response",s_0,arg_0,s_1).
template("Not Chain Response",s_1,__skip__,s_0).
template("Not Chain Response",s_0,arg_1,s_0).
template("Not Chain Response",s_1,arg_0,s_1).
template("Not Chain Response",s_2,arg_0,s_2).
template("Not Chain Response",s_2,arg_1,s_2).
template("Not Chain Response",s_2,__skip__,s_2).
template("Not Chain Response",s_0,__skip__,s_0).
template("Not Chain Response",s_1,arg_1,s_2).

initial("Not Chain Response",s_0).

accepting("Not Chain Response",s_0).
accepting("Not Chain Response",s_1).


template("Alternate Succession",s_0,arg_1,s_1).
template("Alternate Succession",s_1,arg_0,s_1).
template("Alternate Succession",s_2,__skip__,s_2).
template("Alternate Succession",s_0,__skip__,s_0).
template("Alternate Succession",s_2,arg_0,s_1).
template("Alternate Succession",s_0,arg_0,s_2).
template("Alternate Succession",s_1,arg_1,s_1).
template("Alternate Succession",s_2,arg_1,s_0).
template("Alternate Succession",s_1,__skip__,s_1).

initial("Alternate Succession",s_0).

accepting("Alternate Succession",s_0).


template("Response",s_0,arg_0,s_1).
template("Response",s_1,arg_1,s_0).
template("Response",s_0,arg_1,s_0).
template("Response",s_1,arg_0,s_1).
template("Response",s_0,__skip__,s_0).
template("Response",s_1,__skip__,s_1).

initial("Response",s_0).

accepting("Response",s_0).


template("Chain Precedence",s_0,arg_1,s_1).
template("Chain Precedence",s_0,__skip__,s_1).
template("Chain Precedence",s_2,arg_1,s_2).
template("Chain Precedence",s_2,arg_0,s_2).
template("Chain Precedence",s_0,arg_0,s_0).
template("Chain Precedence",s_2,__skip__,s_2).
template("Chain Precedence",s_1,arg_0,s_0).
template("Chain Precedence",s_1,arg_1,s_2).
template("Chain Precedence",s_1,__skip__,s_1).

initial("Chain Precedence",s_0).

accepting("Chain Precedence",s_0).
accepting("Chain Precedence",s_1).


template("Chain Succession",s_3,arg_0,s_1).
template("Chain Succession",s_3,__skip__,s_1).
template("Chain Succession",s_1,arg_0,s_1).
template("Chain Succession",s_2,arg_0,s_3).
template("Chain Succession",s_0,arg_0,s_3).
template("Chain Succession",s_2,__skip__,s_2).
template("Chain Succession",s_0,arg_1,s_2).
template("Chain Succession",s_3,arg_1,s_2).
template("Chain Succession",s_2,arg_1,s_1).
template("Chain Succession",s_1,arg_1,s_1).
template("Chain Succession",s_0,__skip__,s_2).
template("Chain Succession",s_1,__skip__,s_1).

initial("Chain Succession",s_0).

accepting("Chain Succession",s_0).
accepting("Chain Succession",s_2).


template("Precedence",s_0,arg_1,s_1).
template("Precedence",s_2,arg_1,s_2).
template("Precedence",s_1,arg_0,s_1).
template("Precedence",s_2,arg_0,s_2).
template("Precedence",s_2,__skip__,s_2).
template("Precedence",s_0,__skip__,s_0).
template("Precedence",s_0,arg_0,s_2).
template("Precedence",s_1,arg_1,s_1).
template("Precedence",s_1,__skip__,s_1).

initial("Precedence",s_0).

accepting("Precedence",s_0).
accepting("Precedence",s_2).


template("Co-Existence",s_0,arg_0,s_1).
template("Co-Existence",s_2,arg_1,s_2).
template("Co-Existence",s_1,arg_0,s_1).
template("Co-Existence",s_1,arg_1,s_3).
template("Co-Existence",s_3,arg_1,s_3).
template("Co-Existence",s_3,arg_0,s_3).
template("Co-Existence",s_2,__skip__,s_2).
template("Co-Existence",s_0,__skip__,s_0).
template("Co-Existence",s_3,__skip__,s_3).
template("Co-Existence",s_0,arg_1,s_2).
template("Co-Existence",s_2,arg_0,s_3).
template("Co-Existence",s_1,__skip__,s_1).

initial("Co-Existence",s_0).

accepting("Co-Existence",s_0).
accepting("Co-Existence",s_3).


template("Succession",s_1,arg_0,s_2).
template("Succession",s_2,arg_0,s_2).
template("Succession",s_3,arg_1,s_3).
template("Succession",s_0,arg_1,s_3).
template("Succession",s_3,arg_0,s_3).
template("Succession",s_2,__skip__,s_2).
template("Succession",s_0,__skip__,s_0).
template("Succession",s_3,__skip__,s_3).
template("Succession",s_0,arg_0,s_2).
template("Succession",s_2,arg_1,s_1).
template("Succession",s_1,arg_1,s_1).
template("Succession",s_1,__skip__,s_1).

initial("Succession",s_0).

accepting("Succession",s_0).
accepting("Succession",s_1).


template("Absence",s_1,arg_0,s_1).
template("Absence",s_0,arg_0,s_1).
template("Absence",s_1,__skip__,s_1).
template("Absence",s_0,__skip__,s_0).

initial("Absence",s_0).

accepting("Absence",s_0).


template("Existence2",s_1,arg_0,s_1).
template("Existence2",s_2,__skip__,s_2).
template("Existence2",s_0,__skip__,s_0).
template("Existence2",s_2,arg_0,s_1).
template("Existence2",s_0,arg_0,s_2).
template("Existence2",s_1,__skip__,s_1).

initial("Existence2",s_0).

accepting("Existence2",s_1).


template("Init",s_0,arg_0,s_1).
template("Init",s_1,arg_0,s_1).
template("Init",s_2,arg_0,s_2).
template("Init",s_2,__skip__,s_2).
template("Init",s_0,__skip__,s_2).
template("Init",s_1,__skip__,s_1).

initial("Init",s_0).

accepting("Init",s_1).


template("Alternate Precedence",s_0,arg_1,s_1).
template("Alternate Precedence",s_1,arg_0,s_1).
template("Alternate Precedence",s_2,arg_0,s_2).
template("Alternate Precedence",s_2,__skip__,s_2).
template("Alternate Precedence",s_0,__skip__,s_0).
template("Alternate Precedence",s_0,arg_0,s_2).
template("Alternate Precedence",s_1,arg_1,s_1).
template("Alternate Precedence",s_2,arg_1,s_0).
template("Alternate Precedence",s_1,__skip__,s_1).

initial("Alternate Precedence",s_0).

accepting("Alternate Precedence",s_0).
accepting("Alternate Precedence",s_2).


template("Not Responded Existence",s_0,arg_0,s_1).
template("Not Responded Existence",s_2,arg_1,s_2).
template("Not Responded Existence",s_1,arg_0,s_1).
template("Not Responded Existence",s_1,arg_1,s_3).
template("Not Responded Existence",s_3,arg_1,s_3).
template("Not Responded Existence",s_3,arg_0,s_3).
template("Not Responded Existence",s_2,__skip__,s_2).
template("Not Responded Existence",s_0,__skip__,s_0).
template("Not Responded Existence",s_3,__skip__,s_3).
template("Not Responded Existence",s_0,arg_1,s_2).
template("Not Responded Existence",s_2,arg_0,s_3).
template("Not Responded Existence",s_1,__skip__,s_1).

initial("Not Responded Existence",s_0).

accepting("Not Responded Existence",s_0).
accepting("Not Responded Existence",s_1).
accepting("Not Responded Existence",s_2).


template("Absence3",s_3,arg_0,s_3).
template("Absence3",s_2,__skip__,s_2).
template("Absence3",s_0,__skip__,s_0).
template("Absence3",s_2,arg_0,s_1).
template("Absence3",s_3,__skip__,s_3).
template("Absence3",s_1,arg_0,s_3).
template("Absence3",s_0,arg_0,s_2).
template("Absence3",s_1,__skip__,s_1).

initial("Absence3",s_0).

accepting("Absence3",s_0).
accepting("Absence3",s_1).
accepting("Absence3",s_2).


