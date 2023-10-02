
constraint(1, "Not Chain Succession").
bind(1, arg_0, "a").
bind(1, arg_1, "b").
constraint(1, "Not Chain Succession", ((arg_0, "a"), (arg_1, "b"))).

