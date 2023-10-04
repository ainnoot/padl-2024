#! /usr/bin/sh

TEMPLATES_DEFINITIONS=$1

echo "Cleaning up..."
rm -f automata/templates.lp
rm -f ltlf_base/templates.lp
rm -f ltlf_xnf/templates.lp
%rm -f ltlf_dag/templates.lp

echo "Compiling automata..."
python3 compile_template_automata.py $1 > automata/templates.lp

echo "Compiling syntax trees..."
python3 compile_template_syntax_tree.py $1 > ltlf_base/templates.lp
cp ltlf_base/templates.lp ltlf_xnf/templates.lp

%echo "Compiling DAGs..."
%python3 compile_template_dag.py $1 > ltlf_dag/templates.lp
