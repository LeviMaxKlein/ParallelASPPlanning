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
        memory_per_cpu="8192", # adapt according to needs, this is per run and should be 100MB larger than the memory limit of the solver(s)
        extra_options=f"#SBATCH --chdir={SCRIPT_DIR}"
        )
    ENV.job_dir = SCRIPT_DIR
else:
    ENV= LocalEnvironment(processes=1)

ARGPARSER.add_argument(
    "--heuristic", action="store_true", help="run with a heuristic"
)
ARGPARSER.add_argument(
    "--strong-mutex", action="store_true", help="run with stronger mutexes"
)
ARGPARSER.add_argument(
    "--algos", nargs="*", help="specify algorithm: sequential, forall, exists, exists_edge, relaxed" 
)
ARGPARSER.add_argument(
    "--domains", nargs="*", help="specify domains"
)
args, _ = ARGPARSER.parse_known_args()

SUITES = args.domains if args.domains else [
    "agricola-sat18-strips", "airport", "barman-sat11-strips", "barman-sat14-strips", "blocks", "childsnack-sat14-strips",
    "data-network-sat18-strips", "depot", "driverlog", "elevators-sat08-strips", "elevators-sat11-strips", "floortile-sat11-strips",
    "floortile-sat14-strips", "freecell", "ged-sat14-strips", "grid", "gripper", "hiking-sat14-strips", "logistics00", "logistics98",
    "miconic", "movie", "mprime", "mystery", "nomystery-sat11-strips", "openstacks-sat08-strips", "openstacks-sat11-strips", "openstacks-sat14-strips",
    "openstacks-strips", "organic-synthesis-sat18-strips", "organic-synthesis-split-sat18-strips", "parcprinter-08-strips", "parcprinter-sat11-strips",
    "parking-sat11-strips", "parking-sat14-strips", "pathways", "pegsol-08-strips", "pegsol-sat11-strips", "pipesworld-notankage", "pipesworld-tankage",
    "psr-small", "quantum-layout-sat23-strips", "rovers", "satellite", "scanalyzer-08-strips", "scanalyzer-sat11-strips", "snake-sat18-strips", "sokoban-sat08-strips",
    "sokoban-sat11-strips", "spider-sat18-strips", "storage", "termes-sat18-strips", "tetris-sat14-strips", "thoughtful-sat14-strips", "tidybot-sat11-strips",
    "tpp", "transport-sat08-strips", "transport-sat11-strips", "transport-sat14-strips", "trucks-strips", "visitall-sat11-strips", "visitall-sat14-strips",
    "woodworking-sat08-strips", "woodworking-sat11-strips", "zenotravel"]
ALGORITHM = args.algos if args.algos else ["sequential", "forall", "exists", "exists_edge", "relaxed"]
TIME_LIMIT = 1_800
MEMORY_LIMIT = 8000
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
  
    parser = Parser()
    parser.add_pattern("node", r"node: (.+)\n", type=str, file="driver.log", required=True) 
    parser.add_pattern("result", r"^(SATISFIABLE|UNSATISFIABLE|UNKNOWN)", type=str, file="run.log")
    parser.add_pattern("clingo_total_time", r"Time\s*:\s*([\d.]+)s", type=float, file="run.log")
    parser.add_pattern("clingo_search_time", r"Solving:\s*([\d.]+)s", type=float,file="run.log")
    parser.add_pattern("clingo_first_model_time", r"1st Model:\s*([\d.]+)s", type=float, file="run.log")
    parser.add_pattern("clingo_unsat_time", r"Unsat:\s*([\d.]+)s", type=float, file="run.log")
    parser.add_function(solved)
    parser.add_function(check_wrong_plan)
    parser.add_function(error)
    return parser

def remove_unsat_times(run):
    unsat_time = run.get("clingo_unsat_time")
    result = run.get("result")
    if unsat_time:
        run["clingo_unsat_time"] = 0 if result == "SATISFIABLE" else unsat_time
    return True

def create_plots():
    properties_file = Path(exp.path + "-eval") / "properties"
    print(properties_file)
    if not os.path.exists(properties_file):
        print(f"Properties file not found: {properties_file}")
        raise FileNotFoundError
    create_heat_map(properties_file)


exp_name = "ParallelASPPlanning"
if args.domains:
    for domain in args.domains:
        exp_name += f"_{domain}"
if args.algos:
    for algo in args.algos:
        exp_name += f"_{algo}"
if args.heuristic:
    exp_name += "_with_heuristic"
if args.strong_mutex:
    exp_name += "_withstrong_mutex"

exp = Experiment(environment=ENV)
exp.path = os.path.join(SCRIPT_DIR, "data", exp_name)
exp.add_parser(make_parser())

for algo in ALGORITHM:
    for task in suites.build_suite(BENCHMARKS_DIR, SUITES):
        run = exp.add_run()
        run.add_resource(algo, f"algorithms/{algo}.lp", symlink=True)

        run_id = str(uuid.uuid4())
        temp_path = f"{TMPDIR}/run_{run_id}"
        run.add_command("setup_tempdir", ["mkdir", "-p" , temp_path])

        cppdl_command = [f"{SCRIPT_DIR}/../cpddl/bin/pddl"]
        if args.strong_mutex:
            cppdl_command.append("--h2")
        cppdl_command.extend(["--fdr-out", f"{temp_path}/output.sas", task.domain_file, task.problem_file])
        run.add_command("cpddl_pddl_to_sas", cppdl_command)

        run.add_command("plasp_sas_to_asp", [f"{SCRIPT_DIR}/../plasp translate {temp_path}/output.sas > {temp_path}/output.lp"], shell=True)
        clingo_command = [f"{SCRIPT_DIR}/../clingo/clingo", "--outf=1", f"--time-limit={TIME_LIMIT}", f"{SCRIPT_DIR}/algorithms/common.lp", f"{{{algo}}}", f"{temp_path}/output.lp"]
        if args.heuristic:
            clingo_command.append(f"{SCRIPT_DIR}/algorithms/heuristic.lp")
        run.add_command("clingo_solve", clingo_command)
        run.add_command("to_parallel", [
            f"MODEL=$(grep -A1 'ANSWER' run.log | tail -n1); "
            f"[ -n \"$MODEL\" ] && echo \"$MODEL\" | {SCRIPT_DIR}/../clingo/clingo --outf=1 - {SCRIPT_DIR}/algorithms/parallel_to_sequential.lp {temp_path}/output.lp | grep -A1 'ANSWER' - | tail -n1 > seq_plan.lp || touch seq_plan.lp"
        ], shell=True)
        run.add_command("to_sas", [sys.executable, f"{SCRIPT_DIR}/occurs2sas_plan.py"])

        run.add_command("validate_plan", ["Validate", task.domain_file, task.problem_file, "sas_plan"])
        run.add_command("rm_tempdir", ["rm", "-rf", temp_path])
        cpddl_opts = "--h2" if args.strong_mutex else ""
        clingo_opts = f"--outf=2 --time-limit={TIME_LIMIT}"
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
exp.add_fetcher(name="fetch")
exp.add_report(BaseReport(attributes=ATTRIBUTES, filter = remove_unsat_times), outfile="report.html")
exp.add_step("plots", lambda: create_plots())
exp.run_steps()