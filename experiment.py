#!/usr/bin/env python3


import os
import sys

from bw_cluster_environments import BWUniEnvironment
from pathlib import Path

from downward.reports.absolute import AbsoluteReport
from downward import suites
from lab.environments import LocalEnvironment
from lab.experiment import Experiment
from lab.parser import Parser
from lab.reports import Attribute

class BaseReport(AbsoluteReport):
    INFO_ATTRIBUTES = ["time_limit", "memory_limit"]
    ERROR_ATTRIBUTES = [
        "domain",
        "problem",
        "algorithm",
        "unexplained_errors",
        "error",
        "node",
    ]

REMOTE = BWUniEnvironment.is_present()
if REMOTE:
    ENV = BWUniEnvironment(
    email="levi.klein@stud.uni-heidelberg.de",
    memory_per_cpu="3500M", # adapt according to needs, this is per run and should be 100MB larger than the memory limit of the solver(s)
    )
else:
    ENV = LocalEnvironment(processes = 1)
BENCHMARKS_DIR = os.environ["DOWNWARD_BENCHMARKS"]
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SUITE_NAMES = ["agricola-opt18-strips", "airport", "barman-opt11-strips", "barman-opt14-strips", "blocks", "childsnack-opt14-strips", "data-network-opt18-strips", "depot", "driverlog", "elevators-opt08-strips", "elevators-opt11-strips", "floortile-opt11-strips", "floortile-opt14-strips", "freecell", "ged-opt14-strips", "grid", "gripper", "hiking-opt14-strips", "logistics00", "logistics98", "miconic", "movie", "mprime", "mystery", "nomystery-opt11-strips", "openstacks-opt08-strips", "openstacks-opt11-strips", "openstacks-opt14-strips", "openstacks-strips", "organic-synthesis-opt18-strips", "organic-synthesis-split-opt18-strips", "parcprinter-08-strips", "parcprinter-opt11-strips", "parking-opt11-strips", "parking-opt14-strips", "pathways", "pegsol-08-strips", "pegsol-opt11-strips", "petri-net-alignment-opt18-strips", "pipesworld-notankage", "pipesworld-tankage", "psr-small", "quantum-layout-opt23-strips", "rovers", "satellite", "scanalyzer-08-strips", "scanalyzer-opt11-strips", "snake-opt18-strips", "sokoban-opt08-strips", "sokoban-opt11-strips", "spider-opt18-strips", "storage", "termes-opt18-strips", "tetris-opt14-strips", "tidybot-opt11-strips", "tidybot-opt14-strips", "tpp", "transport-opt08-strips", "transport-opt11-strips", "transport-opt14-strips", "trucks-strips", "visitall-opt11-strips", "visitall-opt14-strips", "woodworking-opt08-strips", "woodworking-opt11-strips", "zenotravel"]
SUITE = [os.path.join(BENCHMARKS_DIR, names) for names in SUITE_NAMES]
ALGORITHM = ["sequential", "forall", "exists", "relaxed"]
TIME_LIMIT = 1
MEMORY_LIMIT = 1

ATTRIBUTES = [
    "error",
    "solve_time",
    "solver_exit_code",
    Attribute("solved", absolute=True)
]
exp = Experiment(environment=ENV)
exp.add_resource("downward", "../downward", symlink=True)
exp.add_resource("plasp", "plasp/build/release/bin/plasp", symlink=True)
exp.add_resource("plasp_wrapper", "plasp_wrapper.py", symlink=True)
exp.add_resource("common", "common.lp", symlink=True)
for algo in ALGORITHM:
    for task in suites.build_suite(BENCHMARKS_DIR, ["zenotravel", "gripper"]):
        run = exp.add_run()
        run.add_resource(algo, f"{algo}.lp", symlink=True)
        run.add_command("downward_pddl_to_sas", [sys.executable, "{downward}/fast-downward.py", "--translate", BENCHMARKS_DIR + "/" + task.domain + "/domain.pddl", BENCHMARKS_DIR + "/" + task.domain + "/" + task.problem])
        run.add_command("plasp_sas_to_asp", [sys.executable, "{plasp_wrapper}"])
        run.add_command("clingo_solve", ["clingo", "{common}", f"{{{algo}}}", "output.lp"])
        run.add_command("remove_tmp_files", ["rm", "-f", "output.sas", "output.lp"])
        run.set_property("algorithm", algo)
        run.set_property("time_limit", 2000)
        run.set_property("memory_limit", 2000)
        run.set_property("id", [algo, task.domain, task.problem])
exp.add_step("build", exp.build)
exp.add_step("start", exp.start_runs)
exp.run_steps()

