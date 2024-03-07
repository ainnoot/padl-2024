constraint(0, "Precedence").
bind(0, arg_0, "Antibiotics").
bind(0, arg_1, "IV Liquid").

constraint(1, "Exclusive Choice").
bind(1, arg_0, "Release A").
bind(1, arg_1, "Release B").

constraint(2, "Chain Precedence").
bind(2, arg_0, "ER Triage").
bind(2, arg_1, "Admission IC").
