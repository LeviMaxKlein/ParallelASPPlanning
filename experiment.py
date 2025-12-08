#!/usr/bin/env python3


import os
import sys
import json

from bw_cluster_environments import BWUniEnvironment
from pathlib import Path

from downward.reports.absolute import AbsoluteReport
from downward.reports.scatter import ScatterPlotReport
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
    memory_per_cpu="32768", # adapt according to needs, this is per run and should be 100MB larger than the memory limit of the solver(s)
    )
else:
    ENV = LocalEnvironment(processes=1)

BENCHMARKS_DIR = os.environ["DOWNWARD_BENCHMARKS"]
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SUITES = ["agricola-sat18-strips", "airport", "barman-sat11-strips", "barman-sat14-strips", "blocks", "childsnack-sat14-strips", "data-network-sat18-strips", "depot", "driverlog", "elevators-sat08-strips", "elevators-sat11-strips", "floortile-sat11-strips", "floortile-sat14-strips", "freecell", "ged-sat14-strips", "grid", "gripper", "hiking-sat14-strips", "logistics00", "logistics98", "miconic", "movie", "mprime", "mystery", "nomystery-sat11-strips", "openstacks-sat08-strips", "openstacks-sat11-strips", "openstacks-sat14-strips", "openstacks-strips", "organic-synthesis-sat18-strips", "organic-synthesis-split-sat18-strips", "parcprinter-08-strips", "parcprinter-sat11-strips", "parking-sat11-strips", "parking-sat14-strips", "pathways", "pegsol-08-strips", "pegsol-sat11-strips", "pipesworld-notankage", "pipesworld-tankage", "psr-small", "quantum-layout-sat23-strips", "rovers", "satellite", "scanalyzer-08-strips", "scanalyzer-sat11-strips", "snake-sat18-strips", "sokoban-sat08-strips", "sokoban-sat11-strips", "spider-sat18-strips", "storage", "termes-sat18-strips", "tetris-sat14-strips", "thoughtful-sat14-strips", "tidybot-sat11-strips", "tpp", "transport-sat08-strips", "transport-sat11-strips", "transport-sat14-strips", "trucks-strips", "visitall-sat11-strips", "visitall-sat14-strips", "woodworking-sat08-strips", "woodworking-sat11-strips", "zenotravel"]
ALGORITHM = ["sequential", "forall", "exists", "relaxed"]
TIME_LIMIT = 1800
MEMORY_LIMIT = 32600

ATTRIBUTES = [
    "error",
    "result",
    "clingo_total_time",
    "clingo_search_time",
    "clingo_first_model_time",
    "clingo_unsat_time",
    "clingo_wrong_plan",
    Attribute("solved", absolute=True)
]


def make_parser():
    def solved(content, props):
        if "successful plan" in content.lower():
            props["solved"] = 1
        else:
            props["solved"] = 0
    
    def error(content, props):
        if props.get("result", "UNKNOWN") == "UNKNOWN":
            props["error"] = "unsolved"
        else:
            props["error"] = "solved"
    
    def check_wrong_plan(content, props):
        if props.get("result") == "SATISFIABLE" and props.get("solved") == 0:
            props["clingo_wrong_plan"] = 1
        else:
            props["clingo_wrong_plan"] = 0 

    def parse_json_output(content, props):
        try:
            data = json.loads(content)
            if 'Time' in data:
                props['clingo_total_time'] = data['Time'].get('Total', 0)
                props['clingo_search_time'] = data['Time'].get('Solve', 0)
                props['clingo_unsat_time'] = data['Time'].get('Unsat', 0)
                props['clingo_first_model_time'] = data['Time'].get('Model', 0)
            
            # Result
            if 'Result' in data:
                props['result'] = data['Result']
        except (json.JSONDecodeError, KeyError) as e:
            pass

    parser = Parser()
    parser.add_function(parse_json_output, file="output.json")
    parser.add_function(solved)
    parser.add_function(check_wrong_plan)
    parser.add_function(error)
    return parser

def create_plots():
    properties_file = Path(SCRIPT_DIR) / "../experiment-eval/properties"
    print(properties_file)

    if not os.path.exists(properties_file):
        print(f"Properties file not found: {properties_file}")
        raise FileNotFoundError
    create_heat_map(properties_file)

def remove_explained_errors(run):
    errors = run.get("unexplained_errors")
    if errors:
        filtered= [
            error for error in errors
            if "occurs" not in error and "output-to-slurm.err" not in error
        ]
        run["unexplained_errors"]=filtered
    return True

def remove_unsat_times(run):
    unsat_time = run.get("clingo_unsat_time")
    result = run.get("result")
    if unsat_time:
        run["clingo_unsat_time"] = 0 if result == "SATISFIABLE" else unsat_time
    return True

exp = Experiment(environment=ENV)
exp.add_parser(make_parser())
for algo in ALGORITHM:
    for task in suites.build_suite(BENCHMARKS_DIR, SUITES):
        run = exp.add_run()
        run.add_resource(algo, f"algorithms/{algo}.lp", symlink=True)
        #run.add_command("downward_pddl_to_sas", [sys.executable, Path(SCRIPT_DIR) / "../downward/fast-downward.py", "--translate", task.domain_file, task.problem_file])
        run.add_command("cpddl_pddl_to_sas", [f"{Path(SCRIPT_DIR)}/../cpddl/bin/pddl", "--fdr-out", "./output.sas", task.domain_file, task.problem_file])
        run.add_command("plasp_sas_to_asp", [f"{SCRIPT_DIR}/../plasp translate output.sas > output.lp"], shell=True)
        run.add_command("clingo_solve", [f"{SCRIPT_DIR}/../clingo/clingo --outf=2 --time-limit={TIME_LIMIT} {Path(SCRIPT_DIR) / 'algorithms' / 'common.lp'} {{{algo}}} output.lp > output.json"], shell=True)
        run.add_command("extract_occurs", [sys.executable, f"{SCRIPT_DIR}/extract_occurs.py"])
        run.add_command("parallel_to_seq", [f"{SCRIPT_DIR}/../clingo/clingo --outf=2 output.lp {Path(SCRIPT_DIR) / "algorithms" / "parallel_to_sequential.lp"} plan.lp > sequential.json"], shell=True)
        run.add_command("lp_to_sas_plan", [sys.executable, f"{SCRIPT_DIR}/lp_to_sas_plan.py"])
        run.add_command("validate_plan", ["Validate", "-v", task.domain_file, task.problem_file, "sas_plan"])
        run.add_command("remove_tmp_files", ["rm", "-f", "output.sas", "output.lp", "sequential.json", "plan.lp", "sas_plan"])
        run.set_property("component_optins", f"clingo --timit-limit={TIME_LIMIT} common.lp {algo} output.lp")
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
exp.add_report(BaseReport(attributes=ATTRIBUTES, filter = remove_unsat_times), outfile="report.html")
exp.add_step("plots", lambda: create_plots())
exp.run_steps()
