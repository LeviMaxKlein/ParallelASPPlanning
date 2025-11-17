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
from plot import create_heat_map

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
    memory_per_cpu="8192M", # adapt according to needs, this is per run and should be 100MB larger than the memory limit of the solver(s)
    )
else:
    ENV = LocalEnvironment(processes=1)
BENCHMARKS_DIR = os.environ["DOWNWARD_BENCHMARKS"]
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SUITE_NAMES = ["agricola-opt18-strips", "airport", "barman-opt11-strips", "barman-opt14-strips", "blocks", "childsnack-opt14-strips", "data-network-opt18-strips", "depot", "driverlog", "elevators-opt08-strips", "elevators-opt11-strips", "floortile-opt11-strips", "floortile-opt14-strips", "freecell", "ged-opt14-strips", "grid", "gripper", "hiking-opt14-strips", "logistics00", "logistics98", "miconic", "movie", "mprime", "mystery", "nomystery-opt11-strips", "openstacks-opt08-strips", "openstacks-opt11-strips", "openstacks-opt14-strips", "openstacks-strips", "organic-synthesis-opt18-strips", "organic-synthesis-split-opt18-strips", "parcprinter-08-strips", "parcprinter-opt11-strips", "parking-opt11-strips", "parking-opt14-strips", "pathways", "pegsol-08-strips", "pegsol-opt11-strips", "petri-net-alignment-opt18-strips", "pipesworld-notankage", "pipesworld-tankage", "psr-small", "quantum-layout-opt23-strips", "rovers", "satellite", "scanalyzer-08-strips", "scanalyzer-opt11-strips", "snake-opt18-strips", "sokoban-opt08-strips", "sokoban-opt11-strips", "spider-opt18-strips", "storage", "termes-opt18-strips", "tetris-opt14-strips", "tidybot-opt11-strips", "tidybot-opt14-strips", "tpp", "transport-opt08-strips", "transport-opt11-strips", "transport-opt14-strips", "trucks-strips", "visitall-opt11-strips", "visitall-opt14-strips", "woodworking-opt08-strips", "woodworking-opt11-strips", "zenotravel"]
SUITE = [os.path.join(BENCHMARKS_DIR, names) for names in SUITE_NAMES]
ALGORITHM = ["sequential", "forall", "exists", "relaxed"]
TIME_LIMIT = 600
MEMORY_LIMIT = 8000

ATTRIBUTES = [
    "error",
    "result",
    "clingo_total_time",
    "clingo_search_time",
    "clingo_first_model_time",
    "clingo_unsat_time",
    Attribute("solved", absolute=True)
]


def make_parser():
    def solved(content, props):
        if props.get("result", "UNKNOWN") != "UNKNOWN":
            props["solved"] = 1
        else:
            props["solved"] = 0
    
    def error(content, props):
        if props.get("result", "UNKNOWN") == "UNKNOWN":
            props["error"] = "unsolved"
        else:
            props["error"] = "solved"

    parser = Parser()
    parser.add_pattern("node", r"node: (.+)\n", type=str, file="driver.log", required=True)
    parser.add_pattern("result", r"(SATISFIABLE|UNSATISFIABLE|UNKNOWN)", type=str, file="run.log")
    parser.add_pattern("clingo_total_time", r"Time\s+:\s+(\d+\.\d+)s", type=float, file="run.log")
    parser.add_pattern("clingo_search_time", r"Solving:\s+(\d+\.\d+)s", type=float, file="run.log")
    parser.add_pattern("clingo_first_model_time", r"1st Model:\s+(\d+\.\d+)s", type=float, file="run.log")
    parser.add_pattern("clingo_unsat_time", r"Unsat:\s+(\d+\.\d+)s", type=float, file="run.log")

    parser.add_function(solved)
    parser.add_function(error)
    return parser

def create_plots():
    properties_file = Path(SCRIPT_DIR) / "../experiment-eval/properties"

    if not os.path.exists(properties_file):
        print(f"Properties file not found: {properties_file}")
        raise FileNotFoundError
    create_heat_map(properties_file)


def remove_explained_errors(run):
    explained_messages = ["run.err: ../../common.lp:11:1-16: info: no atoms over signature occur in program:\n  occurs/2\n\n"]
    errors = run.get("unexplained_errors")
    if errors:
        run["unexplained_errors"] = [
            error for error in errors
            if all(msg not in error for msg in explained_messages)]
    return True

def remove_unsat_times(run):
    unsat_times = run.get("clingo_unsat_time")
    result = run.get("result")
    if unsat_times:
        run["clingo_unsat_times"] = [unsat_time for unsat_time in unsat_times if result != "SATISFIABLE"]
    return True

exp = Experiment(environment=ENV)
exp.add_resource("fast_downward", "../downward/fast-downward.py", symlink=True)
exp.add_resource("plasp", "../plasp", symlink=True)
exp.add_resource("plasp_wrapper", "plasp_wrapper.py", symlink=True)
exp.add_resource("clingo", "../clingo/clingo", symlink=True)
exp.add_resource("common", "common.lp", symlink=True)
exp.add_parser(make_parser())
for algo in ALGORITHM:
    for task in suites.build_suite(BENCHMARKS_DIR, ["zenotravel"]):
        run = exp.add_run()
        run.add_resource(algo, f"{algo}.lp", symlink=True)
        run.add_command("downward_pddl_to_sas", [sys.executable, "{fast_downward}", "--translate", Path(BENCHMARKS_DIR) / task.domain / "domain.pddl", Path(BENCHMARKS_DIR) / task.domain / task.problem])
        run.add_command("plasp_sas_to_asp", [sys.executable, "{plasp_wrapper}"])
        run.add_command("clingo_solve", ["{clingo}", "{common}", f"{{{algo}}}", "output.lp"])
        run.add_command("remove_tmp_files", ["rm", "-f", "output.sas", "output.lp"])
        run.set_property("component_optins", "clingo {common} {algo} output.lp")
        run.set_property("domain", task.domain)
        run.set_property("problem", task.problem)
        run.set_property("algorithm", algo)
        run.set_property("time_limit", TIME_LIMIT)
        run.set_property("memory_limit", MEMORY_LIMIT)
        run.set_property("id", [algo, task.domain, task.problem])
exp.add_step("build", exp.build)
exp.add_step("start", exp.start_runs)
exp.add_step("parse", exp.parse)
exp.add_fetcher(name="fetch")
exp.add_report(BaseReport(attributes=ATTRIBUTES), outfile="report.html", filter = [remove_explained_errors, remove_unsat_times])
exp.add_step("plots", lambda: create_plots())
exp.run_steps()

