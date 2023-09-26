
constraint(1, "Chain Precedence").
bind(1, arg_0, "a").
bind(1, arg_1, "b").
constraint(1, "Chain Precedence", ((arg_0, "a"), (arg_1, "b"))).

