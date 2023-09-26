
constraint(1, "Exclusive Choice").
bind(1, arg_0, "a").
bind(1, arg_1, "b").
constraint(1, "Exclusive Choice", ((arg_0, "a"), (arg_1, "b"))).

