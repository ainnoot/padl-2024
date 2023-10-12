# ASP encodings
The full version of ASP encodings reported in the paper are in the following folders:

* Automata: `automata/semantics.lp`
* Syntax tree: `ltlf_base/semantics.lp`
* Direct ASP: `asp_native/semantics.lp`

## Are they really doing the same thing? 
The `testing/fuzz.py` script implements a _bounded model checking_-like approach to search for counterexamples that show that `automata`, `ltlf_base` and `asp_native` behave in a different way over Declare constraints:

```bash
python3 testing/fuzz.py
```

## `archived`
This folder contains encodings that did not make it into the paper, variants of `ltlf_base`. `ltlf_dag` uses a s-expression encoding of LTLf formulae, to share evaluation of subformulae. This is not so relevant on Declare constraints, since the LTLf formulae equivalent of Declare constraints has low-depth thus shared evaluation of subformulae does not have a big effect. `ltlf_xnf` is an alternative encoding of temporal semantics' as normal programs, that evaluates the (equivalent) next normal form of a formula rather than the original formula. This ends up using less maximum memory during evaluation, but the encoding results still subpar wrt `automata` and `asp_native`.

this searches for counterexamples over all the constraints in `testing/declare_constraints` -- all the ones used in the experiments.

# Setting up a virtual environment
The project requires `python3.10`. You can set up a virtual environment by the following, assuming a `bash` shell environment:

```bash
# Create & Activate a virtual environment
python3.10 -m venv venv
source venv/bin/activate

# Install requirements
pip install -r requirements.txt
```

# Compiling automata, syntax trees for custom LTLf formulae.
`declare_templates.txt` contains the LTLf definitions of the Declare templates used for benchmarking purposes in the paper.

You can use the script `compile_templates.sh` to reify the LTLf formulae into the corresponding facts. The output is stored into `automata/templates.lp` and `ltlf_base/templates.lp`. **The direct ASP encodings for Declare constraints are not algorithmically generated - thus they are not available for custom LTLf formulae**.

# Running standalone tasks
You can execute the conformance checking and query checking as standalone tasks on custom XES logs and with custom `decl` models by running the `conformance_checking.py` scripts and `query_checking.py` scripts. 

...

Scattered around the repositories there are some scripts to parse XES event logs and `decl` Declare models into an ASP fact format - these **do not** need to be executed, `conformance_checking.py` and `conformance_checking.py` works with XES and `decl` inputs.

# Reproducing experiments

## Pre-processing data
In order to reproduce the experiments in the paper, you need to first generate data out of logs contained in the `source_logs` folder. You can do so by running:

```bash
python3 prepare_data.py [source log dir] [target dir]
```

The preprocessing step roughly covers the step in the `Data` section in Section 5 in the paper, creating Declare models in `decl` format for each XES log in `source log dir` and storing it into a neat folder structure in the `target dir` tree.

## Running experiments
Once data is prepared, you can run the experiments by running:

```bash
python3 run_paper_experiments.py [data] [results] [output logs]
```

where `logs` is a folder that contains XES event logs, `results` is the folder where outputs are stored and `data` is the `target dir` of the preprocessing steps over the source logs. 
The scripts executes all the conformance checking tasks and query checking tasks, as defined in Section 5 of the paper, using the methods in the `METHODS` variable in `run_paper_experiments.py`.
The `output logs` folder stores a compact log of experiments' results, that can be used to generate plots and figures.

**In the checked out version, the default is running the experiments only for the `asp_native` method. You need to edit the `METHODS` variable in `run_paper_experiments.py` to `['asp_native', 'ltlf_base', 'd4py', 'automata']` in order to run all the experiments.**

**`*_backup` folders are the original data plotted in the paper.**

# Validating outputs
You can use the `validate.py` script to check that all the methods output the same things, for conformance checking and query checking tasks:

```bash
python3 validate.py [results]
``` 

where `results` is the results folder of the `run_paper_experiments.py` step. **At the time of writing, some Declare4Py constraint checkers exhibit some bugs - which have been reported to the maintainers. Since the procedures to check constraints are imperative, it is unlikely results on runtime are affected -- this is mainly to check that the ASP-methods report consistent results between them**.

# Plots, tables
In the `plots` folder there are some scripts to reproduce the datapoints that are used to generate the pictures in the paper and the tables.
