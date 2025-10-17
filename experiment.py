#TODO:
# 1. PDDL -> SAS mit Downward 
# 2. SAS -> ASP mit Plasp
# 3. lösen mit Clingo


import os
import sys
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


SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BENCHMARKS_DIR = os.path.join(SCRIPT_DIR, "downward-benchmarks")
SUITE_NAMES = ["agricola-opt18-strips", "airport", "barman-opt11-strips", "barman-opt14-strips", "blocks", "childsnack-opt14-strips", "data-network-opt18-strips", "depot", "driverlog", "elevators-opt08-strips", "elevators-opt11-strips", "floortile-opt11-strips", "floortile-opt14-strips", "freecell", "ged-opt14-strips", "grid", "gripper", "hiking-opt14-strips", "logistics00", "logistics98", "miconic", "movie", "mprime", "mystery", "nomystery-opt11-strips", "openstacks-opt08-strips", "openstacks-opt11-strips", "openstacks-opt14-strips", "openstacks-strips", "organic-synthesis-opt18-strips", "organic-synthesis-split-opt18-strips", "parcprinter-08-strips", "parcprinter-opt11-strips", "parking-opt11-strips", "parking-opt14-strips", "pathways", "pegsol-08-strips", "pegsol-opt11-strips", "petri-net-alignment-opt18-strips", "pipesworld-notankage", "pipesworld-tankage", "psr-small", "quantum-layout-opt23-strips", "rovers", "satellite", "scanalyzer-08-strips", "scanalyzer-opt11-strips", "snake-opt18-strips", "sokoban-opt08-strips", "sokoban-opt11-strips", "spider-opt18-strips", "storage", "termes-opt18-strips", "tetris-opt14-strips", "tidybot-opt11-strips", "tidybot-opt14-strips", "tpp", "transport-opt08-strips", "transport-opt11-strips", "transport-opt14-strips", "trucks-strips", "visitall-opt11-strips", "visitall-opt14-strips", "woodworking-opt08-strips", "woodworking-opt11-strips", "zenotravel"]
SUITE = [os.path.join(BENCHMARKS_DIR, names) for names in SUITE_NAMES]
ALGORITHM = ["sequential.lp", "forall.lp", "exists.lp", "relaxed.lp"]
TIME_LIMIT = 1
MEMORY_LIMIT = 1
ENV = LocalEnvironment(processes=1)

ATTRIBUTES = [
    "error",
    "solve_time",
    "solver_exit_code",
    Attribute("solved", absolute=True)
]
#domain = BENCHMARKS_DIR / "zenotravel/domain.pddl"
#problem = BENCHMARKS_DIR / "zenotravel/p01.pddl"
exp = Experiment(environment=ENV)
for task in suites.build_suite(BENCHMARKS_DIR, ["zenotravel", "gripper"]):
    print(task.domain)
    print(task.problem)
    run = exp.add_run()
    run.add_resource("downward", "../downward", symlink=True)
    run.add_command("downward_translate", [sys.executable, "{downward}/fast-downward.py", "--translate", BENCHMARKS_DIR + "/" + task.domain + "/domain.pddl", BENCHMARKS_DIR + "/" + task.domain + "/" + task.problem])
    run.set_property("time_limit", 2000)
    run.set_property("memory_limit", 2000)
    run.set_property("id", [task.domain, task.problem])

exp.add_step("build", exp.build)
exp.add_step("start", exp.start_runs)
exp.run_steps()

