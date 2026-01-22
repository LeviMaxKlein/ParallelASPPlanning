#!/usr/bin/env python3

import os
import sys
import uuid
from bw_cluster_environments import BWUniEnvironment
from pathlib import Path

from downward.reports.absolute import AbsoluteReport
from downward import suites
from lab.environments import LocalEnvironment
from lab.experiment import Experiment
from lab.parser import Parser
from lab.reports import Attribute
from lab.experiment import ARGPARSER
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
BENCHMARKS_DIR = os.environ["DOWNWARD_BENCHMARKS"]
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
TMPDIR = Path(os.environ.get("TMPDIR", "/tmp"))
REMOTE = BWUniEnvironment.is_present()
if REMOTE:
    ENV = BWUniEnvironment(
        email="levi.klein@stud.uni-heidelberg.de",
        memory_per_cpu="32768", # adapt according to needs, this is per run and should be 100MB larger than the memory limit of the solver(s)
        extra_options=f"#SBATCH --chdir={SCRIPT_DIR}"
        )
    ENV.job_dir = SCRIPT_DIR
else:
    ENV= LocalEnvironment(processes=1)

ARGPARSER.add_argument(
    "--heuristic", action="store_true", help="run with a heuristic"
)
ARGPARSER.add_argument(
    "--strong-mutex", action="store_true", help="run with h2 search for mutexes"
)
ARGPARSER.add_argument(
    "--algos", nargs="*", help="specify algorithm" 
)
ARGPARSER.add_argument(
    "--domains", nargs="*", help="specify domains"
)
args, _ = ARGPARSER.parse_known_args()


ALGORITHM = args.algos if args.algos else ["sequential", "forall", "exists", "exists_edge", "relaxed", "guess_and_check"]
TIME_LIMIT = 1_800
MEMORY_LIMIT = 31000 if REMOTE else 8192
ATTRIBUTES = [
    "error",
    "result",
    "clingo_total_time",
    "clingo_search_time",
    "clingo_first_model_time",
    "clingo_unsat_time",
    "clingo_guess_time",
    "failed_check",
    Attribute("solved", absolute=True)
]
SUITES = args.domains if args.domains else [
    "agricola-sat18-strips", "airport", "barman-sat11-strips", "barman-sat14-strips", "blocks", "childsnack-sat14-strips",
    "data-network-sat18-strips", "depot", "driverlog", "elevators-sat08-strips", "elevators-sat11-strips", "floortile-sat11-strips",
    "floortile-sat14-strips", "freecell", "ged-sat14-strips", "grid", "gripper", "hiking-sat14-strips", "logistics00", "logistics98",
    "miconic", "movie", "mprime", "mystery", "nomystery-sat11-strips", "openstacks-sat08-strips", "openstacks-sat11-strips", "openstacks-sat14-strips",
    "openstacks-strips", "organic-synthesis-sat18-strips", "organic-synthesis-split-sat18-strips", "parcprinter-08-strips", "parcprinter-sat11-strips",
    "parking-sat11-strips", "parking-sat14-strips", "pathways", "pegsol-08-strips", "pegsol-sat11-strips", "pipesworld-notankage", "pipesworld-tankage",
    "psr-small", "quantum-layout-sat23-strips", "rovers", "satellite", "scanalyzer-08-strips", "scanalyzer-sat11-strips", "snake-sat18-strips", "sokoban-sat08-strips",
    "sokoban-sat11-strips", "spider-sat18-strips", "termes-sat18-strips", "tetris-sat14-strips", "thoughtful-sat14-strips", "tidybot-sat11-strips",
    "tpp", "transport-sat08-strips", "transport-sat11-strips", "transport-sat14-strips", "trucks-strips", "visitall-sat11-strips", "visitall-sat14-strips",
    "woodworking-sat08-strips", "woodworking-sat11-strips", "zenotravel"]

def make_parser():
    def solved(content, props):
        if "successful plan" in content.lower():
            props["solved"] = 1
        else:
            props["solved"] = 0
    
    def get_result_from_models(content, props):
        models = props.get("models")
        if models is not None:
            if models > 0 or ("Guess Time" in content and models == 0):
                props["result"] = "SATISFIABLE"
            else:
                props["result"] = "UNSATISFIABLE"
        else:
            props["result"] = "UNKNOWN"
    
    def error(content, props):
        result = props.get("result", "UNKNOWN")
        solved = props.get("solved", 0)
        if solved == 1:
            props["error"] = "plan-found"
        elif result == "UNSATISFIABLE":
            props["error"] = "unsolvable"
        elif result == "SATISFIABLE" and solved == 0:
            props["error"] = "wrong-plan"
        else:
            props["error"] = "no-result"
    
    def failed_check(content, props):
        if "Check failed" in content:
            props["failed_check"] = 1
        else:
            props["failed_check"] = 0
  
    parser = Parser()
    parser.add_pattern("node", r"node: (.+)\n", type=str, file="driver.log", required=True) 
    parser.add_pattern("models", r"Models\s*:\s*(\d+)", type=int, file="run.log")
    parser.add_pattern("clingo_total_time", r"Time\s*:\s*([\d.]+)s", type=float, file="run.log")
    parser.add_pattern("clingo_guess_time", r"Guess Time\s*:\s*([\d.]+)s", type=float, file="run.log")
    parser.add_pattern("clingo_search_time", r"Solving:\s*([\d.]+)s", type=float,file="run.log")
    parser.add_pattern("clingo_first_model_time", r"1st Model:\s*([\d.]+)s", type=float, file="run.log")
    parser.add_pattern("clingo_unsat_time", r"Unsat:\s*([\d.]+)s", type=float, file="run.log")
    parser.add_function(solved)
    parser.add_function(get_result_from_models)
    parser.add_function(failed_check)
    parser.add_function(error)
    return parser

def remove_unsat_times(run):
    unsat_time = run.get("clingo_unsat_time")
    result = run.get("result")
    if unsat_time:
        run["clingo_unsat_time"] = 0 if result == "SATISFIABLE" else unsat_time
    return True

def remove_explained_errors(run):
    explained_messages = ["INTERRUPTED by signal!", "driver.log\" is missing", "driver.log is missing", "Sending shutdown signal...",
                          "info: atom does not occur in any rule head"]
    errors = run.get("unexplained_errors")
    if errors:
        run["unexplained_errors"] = [
            error for error in errors
            if all(msg not in error for msg in explained_messages)]
    return True

def create_plots():
    properties_file = Path(exp.path + "-eval") / "properties"
    print(properties_file)
    if not os.path.exists(properties_file):
        print(f"Properties file not found: {properties_file}")
        raise FileNotFoundError
    create_heat_map(Path(exp.path + "-eval"))


exp_name = "ParallelASPPlanning"
if args.domains:
    for domain in sorted(args.domains):
        exp_name += f"_{domain}"
if args.algos:
    for algo in sorted(args.algos):

        exp_name += f"_{algo}"
if args.heuristic:
    exp_name += "_with_heuristic"
if args.strong_mutex:
    exp_name += "_with_strong_mutex"

exp = Experiment(environment=ENV)
exp.path = os.path.join(SCRIPT_DIR, "data", exp_name)
exp.add_parser(make_parser())

for algo in ALGORITHM:
    for task in suites.build_suite(BENCHMARKS_DIR, SUITES):
        run = exp.add_run()
        if "guess_and_check" in algo:
            run.add_resource("guess", f"algorithms/guess.lp", symlink=True)
            run.add_resource("check", f"algorithms/check.lp", symlink=True)
        else:
            run.add_resource(algo, f"algorithms/{algo}.lp", symlink=True)

        run_id = str(uuid.uuid4())
        temp_path = f"{TMPDIR}/run_{run_id}"
        run.add_command("setup_tempdir", ["mkdir", "-p" , temp_path])
        run.add_command("copy_domain", ["cp", task.domain_file, f"{temp_path}/domain.pddl"])
        run.add_command("copy_problem", ["cp", task.problem_file, f"{temp_path}/problem.pddl"])
        
        run.add_command("run_pipeline", [sys.executable, f"{SCRIPT_DIR}/pipeline.py", SCRIPT_DIR, TIME_LIMIT, temp_path, f"{temp_path}/domain.pddl", f"{temp_path}/problem.pddl", f"{{{algo}}}" if "guess_and_check" not in algo else algo, str(args.strong_mutex), str(args.heuristic)])
        run.add_command("validate_plan", ["Validate", f"{temp_path}/domain.pddl", f"{temp_path}/problem.pddl", f"{temp_path}/sas_plan"])
        run.add_command("rm_tempdir", ["rm", "-rf", temp_path])
        cpddl_opts = "--h2 --P-h2fwbw-time-limit" if args.strong_mutex else ""
        clingo_opts = f"--outf=1 --time-limit={TIME_LIMIT}"
        if args.heuristic:
            clingo_opts += " heuristic.lp"
        run.set_property("cpddl_options", cpddl_opts)
        run.set_property("clingo_options", clingo_opts)
        run.set_property("domain", task.domain)
        run.set_property("problem", task.problem)
        run.set_property("algorithm", algo)
        run.set_property("time_limit", TIME_LIMIT)
        run.set_property("memory_limit", MEMORY_LIMIT)
        run.set_property("id", [algo, task.domain, task.problem])
exp.add_step("build", exp.build)
exp.add_step("start", exp.start_runs)
exp.add_step("parse", exp.parse)
exp.add_fetcher(name="fetch", filter=remove_explained_errors)
exp.add_report(BaseReport(attributes=ATTRIBUTES, filter = remove_unsat_times), outfile="report.html")
exp.add_step("plots", lambda: create_plots())
exp.run_steps()