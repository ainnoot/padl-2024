# TODO

- [ ] Add copyright or something to `flloat` classes, `ltlf2dfa` classes, `processtrace2dfa` classes
- [x] Check that Declare LTLf definition is correctly in the `declare_templates.txt`
  - Taken from AAAI, seems the most complete
- [x] rewrite `ltlf_dag` Clingo script to be a "preprocessing" step as in the other encodings
- [x] custom `flloat` grammar, `LTLfParser` to support `W` operator in Declare constraints
- [x] Fuzz syntax tree encoding wrt automata definitions for each constraint
  - [x] encoding
  - [x] bash scripts
  - [x] be sure-sure-sure all encodings work
    - everything works pair-to-pair

- [ ] Scripts for each task
  - [ ] conformance checking
  - ~[ ] query checking~ stesso motivo, l'ho fatto per KR e non scala bene
  - ~[ ] log generation/bounded satisfiability~ secondo Francesco no, è naive e ASP va male
- [ ] Scripts to benchmark over a suite of logs
- [x] Script to map LTLf into facts
  - [x] automaton encoding
  - [x] syntax tree encoding
  - [x] DAG encoding
  - [x] ad hoc encoding

- [ ] Script to map XES into facts
  - script Chiariello usa `trace(TID,A,T)`, uso dappertutto `trace(TID,T,A)`

- [x] Script to map Declare models into facts
  - [x] d4py -- al momento installandola da pip è rotta e non si può usare
  - [x] minerful
  - [ ] allineare nomim constraint d4py - AAAI

# Fact Schema
## Traces
Traces are encoded by atoms `trace(TID,T,A)`, which denotes that activity `A` occurs at time `T` in the trace with identifier `TID`.

## Model 
A model consists of one or more constraints. Constraints are modeled by atoms `constraint(C,T)` where `C` is a unique identifier for the constraint and `T` is the name of the template which instantiates the constraint.
Arguments are bound by means of the predicate `bind(C,Arg,A)`, which denotes that within constraint `C`, the argument `Arg` is bound to activity `A`.

#### Example
Consider the constraint `Response(a,b)`. This is represented by the facts:

`constraint(c1, "Response"). bind(c1, arg_0, a). bind(c2, arg_1, b).`

# Compiling formulae into facts
A template is an LTLf formula with an associated name. Assuming a set of constraints is stored as key-value pairs in a text file:

```
Response: G(arg_0 -> F(arg_1))
```
where `arg_*` denotes a template variable. Constraints are instantiated by providing substitutions for each variable in the template.

To compile a template into a set of facts, to be used in further conformance checking scripts, run:

```
python3 compile_template_automata.py [input file] > [output file]
python3 compile_template_syntax_tree.py [input file] > [output file]
python3 compile_template_dag.py [input file] > [output file]
```

# Describing a model
## Automata, Syntax Tree, XNF Syntax Tree
A model is a set of constraints. A constraint has a unique identifier, and belongs to a template. For each argument of the corresponding template, each constraint has to bind a value:

```
constraint(c1, "Response").
bind(c1, arg_0, "a").
bind(c2, arg_1, "b").
```

## Syntax Tree DAG
The syntax is a bit more involved, but similar to the previous example:

```
constraint(c1, "Response", ((arg_0, "a"),(arg_1, "b"))).
```

# Conformance Checking

```
clingo [encoding folder]/*.lp model.lp log.lp
```

where `model.lp` is a set of facts according to the `Describing a model` section, `log.lp` is an event log mapped to ASP facts, and `encoding folder` is a folder containing:

- templates of the constraints used in `model.lp`, obtained by running the script in `Compiling formulae into facts`
- `semantics.lp` 

# Fuzzing two encodings
```
clingo fuzz.lp [model] [enc 1]/* [enc 2]/* -c t=[length]
```

if the logic program is satisfiable, there's a witness string that `enc 1`, `enc 2` "behave in a different way", e.g. one of them (the non automata one...) is wrong. If unsatisfiable, there's no witness simple trace up to length `length` that shows errors in the encoding.

`model` should also supply a `activity/1` facts that are the available activities to put within the trace. It is sufficient to use `k+1` activities, where `k` is the total distinct number of activities bound to arguments in constraints. The extra one is needed to model "everything else". (Two activities are 'undistinguishable' if none of them affects a constraint, e.g. none of them is bound to an argument.)
