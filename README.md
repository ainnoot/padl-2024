# TODO

- [ ] Fuzz syntax tree encoding wrt automata definitions for each constraint
  - [x] encoding
  - [ ] bash scripts
  - [ ] be sure-sure-sure all encodings work
- [ ] Scripts for each task
  - [ ] conformance checking
  - [ ] query checking
  - [ ] log generation/bounded satisfiability
- [ ] Scripts to benchmark over a suite of logs
- [x] Script to map LTLf into facts
  - [x] automaton encoding
  - [x] syntax tree encoding
- [ ] Script to map XES into facts
- [ ] Script to map Declare models into facts
  - [ ] d4py
  - [ ] minerful

# Fact Schema
## Traces
Traces are encoded by atoms `trace(TID,T,A)`, which denotes that activity `A` occurs at time `T` in the trace with identifier `TID`.

## Model 
A model consists of one or more constraints. Constraints are modeled by atoms `constraint(C,T)` where `C` is a unique identifier for the constraint and `T` is the name of the template which instantiates the constraint.
Arguments are bound by means of the predicate `bind(C,Arg,A)`, which denotes that within constraint `C`, the argument `Arg` is bound to activity `A`.

#### Example
Consider the constraint `Response(a,b)`. This is represented by the facts:

`constraint(c1, "Response"). bind(c1, arg_0, a). bind(c2, arg_1, b).`
