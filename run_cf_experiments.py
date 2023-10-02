from pathlib import Path
from pyrunlim import pyrunlim_launch
import sys
import shutil
import os
from multiprocessing import Pool


def launch_and_report(x):
    task, (method, log, split), cmd = x
    process_output = pyrunlim_launch(cmd)
    return "{} {} {} {} {:.3f} {:.3f}".format(task, method, log, split, process_output.real, process_output.max_memory)


if __name__ == '__main__':
    data_folder = Path(sys.argv[1])
    results_folder = Path(sys.argv[2], 'conformance_checking')
    logger_file = sys.argv[3]

    Path(results_folder).mkdir(parents=True)
    shutil.rmtree(results_folder)

    methods = ['asp_native', 'd4py', 'ltlf_base', 'automata']
    cf_jobs = []
    qc_jobs = []
    lg_jobs = []

    jobs_to_be_executed = []

    # Run conformance checking with all methods for all available logs and splits
    for log_folder in data_folder.glob('*'):
        log = Path(log_folder / 'log.xes')
        models = list(Path(log_folder / 'models').glob('*.decl'))

        print("Found a log:", log_folder.stem)
        print("Available DECLARE models:")
        for model in models:
            print("\t*", model.stem)
        print()

        # CONFORMANCE CHECKING
        for model in sorted(models):
            for cf_method in methods:
                # results/cf/sepsis/asp_native/split_3/ANS
                output_folder = results_folder / log_folder.stem / cf_method
                output_folder.mkdir(parents=True, exist_ok=True)
                output_file = output_folder / model.stem
                output_file.touch()

                cmd = [
                    "./conformance_checking.py",
                    log.as_posix(),
                    model.as_posix(),
                    "--method={}".format(cf_method),
                    "--output={}".format(str(output_file))
                ]

                # Generate all pyrunlim cmd'			for line in res:
                jobs_to_be_executed.append(
                    ('conformance_checking', (cf_method, log_folder.stem, model.stem), cmd))

    with open(logger_file, 'w+') as f:
        for (task, params, cmd) in jobs_to_be_executed:
            res = launch_and_report((task, params, cmd))
            f.write(res+'\n')
            f.flush()
