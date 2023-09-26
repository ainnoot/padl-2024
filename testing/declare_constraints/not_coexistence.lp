
constraint(1, "Not Coexistence").
bind(1, arg_0, "a").
bind(1, arg_1, "b").
constraint(1, "Not Coexistence", ((arg_0, "a"), (arg_1, "b"))).

