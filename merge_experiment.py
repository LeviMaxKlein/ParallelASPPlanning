#!/usr/bin/env python3

import os
from pathlib import Path
from lab.experiment import Experiment
from downward.reports.scatter import ScatterPlotReport
from lab.environments import LocalEnvironment


SCRIPT_DIR = Path(__file__).parent

exp_no_h = "data/ParallelASPPlanning"  
exp_with_h = "data/ParallelASPPlanning_with_heuristic"
exp_with_s_m = "data/ParallelASPPlanning_with_strong_mutex"
exp_with_h_with_s_m = "data/ParallelASPPlanning_with_heuristic_with_strong_mutex"


def aggregate_domain_variants(run1, run2):
    run1["domain"] = run1["domain"].split("-")[0]
    run2["domain"] = run2["domain"].split("-")[0]
    return run2["domain"]


def filter_time_and_add_total_time(run):
    run["cpddl_time"] = run.get("cpddl_time") if run.get("solved", 0) == 1 else None
    run["clingo_total_time"] = run.get("clingo_total_time") if run.get("solved", 0) == 1 else None
    
    if run["cpddl_time"] is not None and run["clingo_total_time"] is not None:
        run["total_time"] = run["cpddl_time"] + run["clingo_total_time"]

    return True


def rename_with_heuristic(run):
    algo = run.get("algorithm")
    if algo:
        run["algorithm"] = algo + "_heuristic"
        run["id"] = (run["algorithm"], run["domain"], run["problem"])
    return True


def rename_with_mutex(run):
    algo = run.get("algorithm")
    if algo:
        run["algorithm"] = algo + "_strong_mutex"
        run["id"] = (run["algorithm"], run["domain"], run["problem"])
    return True


def rename_with_heuristic_and_mutex(run):
    algo = run.get("algorithm")
    if algo:
        run["algorithm"] = algo + "_heuristic_strong_mutex"
        run["id"] = (run["algorithm"], run["domain"], run["problem"])
    return True


exp = Experiment(environment=LocalEnvironment())
exp.path = os.path.join(SCRIPT_DIR, "data", "comparison_experiment")

if os.path.exists(os.path.join(SCRIPT_DIR, exp_no_h + "-eval")):
    exp.add_fetcher(name="baseline", src=os.path.join(SCRIPT_DIR, exp_no_h + "-eval"), filter=filter_time_and_add_total_time)
if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h + "-eval")):
    exp.add_fetcher(name="heuristic", src=os.path.join(SCRIPT_DIR, exp_with_h + "-eval"), filter=[rename_with_heuristic, filter_time_and_add_total_time], merge=True)
if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_s_m + "-eval")):
    exp.add_fetcher(name="strong_mutex", src=os.path.join(SCRIPT_DIR, exp_with_s_m + "-eval"), filter=[rename_with_mutex, filter_time_and_add_total_time], merge=True)
if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h_with_s_m + "-eval")):
    exp.add_fetcher(name="heuristic_strong_mutex", src=os.path.join(SCRIPT_DIR, exp_with_h_with_s_m + "-eval"), filter=[rename_with_heuristic_and_mutex, filter_time_and_add_total_time], merge=True)

algorithms = ["sequential", "forall", "exists", "exists_edge", "relaxed", "guess_and_check"]



for i, algo in enumerate(algorithms):
    for algo2 in algorithms[i+1:]:
        if algo != algo2:
            if os.path.exists(os.path.join(SCRIPT_DIR, exp_no_h + "-eval")):
                exp.add_report(
                    ScatterPlotReport(
                        get_category=aggregate_domain_variants, 
                        attributes=["clingo_total_time"], 
                        filter_algorithm=[algo, algo2],
                        show_missing=False,
                        title="",
                        matplotlib_options={"legend.fontsize": 1}
                    ), 
                    name=f"{algo}_vs_{algo2}",
                    outfile=f"algo_comparison/{algo}_vs_{algo2}.png"
                )

            if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h + "-eval")):
                exp.add_report(
                    ScatterPlotReport(
                        get_category=aggregate_domain_variants, 
                        attributes=["clingo_total_time"], 
                        filter_algorithm=[algo + "_heuristic", algo2 + "_heuristic"],
                        show_missing=False
                    ), 
                    name=f"{algo}_h_vs_{algo2}_h",
                    outfile=f"{algo}_h_vs_{algo2}_h.png"
                )
            
            if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_s_m + "-eval")):
                exp.add_report(
                    ScatterPlotReport(
                        get_category=aggregate_domain_variants, 
                        attributes=["clingo_total_time"], 
                        filter_algorithm=[algo +"_strong_mutex", algo2 + "_strong_mutex"],
                        show_missing=False
                    ), 
                    name=f"{algo}_s_m_vs_{algo2}_s_m",
                    outfile=f"algo_comparison/{algo}_s_m_vs_{algo2}_s_m.png"
                )

            if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h_with_s_m + "-eval")):
                exp.add_report(
                    ScatterPlotReport(
                        get_category=aggregate_domain_variants, 
                        attributes=["clingo_total_time"], 
                        filter_algorithm=[algo +"_heuristic_strong_mutex", algo2 + "_heuristic_strong_mutex"],
                        show_missing=False
                    ), 
                    name=f"{algo}_h_s_m_vs_{algo2}_h_s_m",
                    outfile=f"algo_comparison/{algo}_h_s_m_vs_{algo2}_h_s_m.png"
                )

    # Baseline
    if os.path.exists(os.path.join(SCRIPT_DIR, exp_no_h + "-eval")):

        # Heuristic
        if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h + "-eval")):
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["clingo_total_time"],
                    filter_algorithm=[algo, algo + "_heuristic"],
                    title="Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_clingo_baseline_vs_heuristic",
                outfile=f"{algo}/baseline_vs_heuristic.png"
            )
        
        # Strong Mutex
        if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_s_m + "-eval")):
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["total_time"],
                    filter_algorithm=[algo, algo + "_strong_mutex"],
                    title="CPPDL + Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_total_time_baseline_vs_strong_mutex",
                outfile=f"{algo}/baseline_vs_strong_mutex_total_time.png"
            )
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["clingo_total_time"],
                    filter_algorithm=[algo, algo + "_strong_mutex"],
                    title="Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_clingo_baseline_vs_strong_mutex",
                outfile=f"{algo}/baseline_vs_strong_mutex_clingo_total_time.png"
            )
        
        # Heuristic + Strong Mutex
        if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h_with_s_m + "-eval")):
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["total_time"],
                    filter_algorithm=[algo, algo + "_heuristic_strong_mutex"],
                    title="CPPDL + Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_total_time_baseline_vs_heuristic_strong_mutex",
                outfile=f"{algo}/baseline_vs_heuristic_strong_mutex_total_time.png"
            )
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["clingo_total_time"],
                    filter_algorithm=[algo, algo + "_heuristic_strong_mutex"],
                    title="Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_clingo_baseline_vs_heuristic_strong_mutex",
                outfile=f"{algo}/baseline_vs_heuristic_strong_mutex_clingo_total_time.png"
            )
    
    # Heuristic
    if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h + "-eval")):

        # Strong Mutex
        if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_s_m + "-eval")):
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["clingo_total_time"],
                    filter_algorithm=[algo + "_heuristic", algo + "_strong_mutex"],
                    title="Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_clingo_heuristic_vs_strong_mutex",
                outfile=f"{algo}/heuristic_vs_strong_mutex_clingo_total_time.png"
            )
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["total_time"],
                    filter_algorithm=[algo + "_heuristic", algo + "_strong_mutex"],
                    title="CPPDL + Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_total_time_heuristic_vs_strong_mutex",
                outfile=f"{algo}/heuristic_vs_strong_mutex_total_time.png"
            )
        
        # Heuristic + Strong Mutex
        if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h_with_s_m + "-eval")):
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["clingo_total_time"],
                    filter_algorithm=[algo + "_heuristic", algo + "_heuristic_strong_mutex"],
                    title="Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_clingo_heuristic_vs_heuristic_strong_mutex",
                outfile=f"{algo}/heuristic_vs_heuristic_strong_mutex_clingo_total_time.png"
            )
            exp.add_report(
                ScatterPlotReport(
                    get_category=aggregate_domain_variants,
                    attributes=["total_time"],
                    filter_algorithm=[algo + "_heuristic", algo + "_heuristic_strong_mutex"],
                    title="CPPDL + Clingo Time",
                    show_missing=False,
                    matplotlib_options={"legend.fontsize": 1}
                ),
                name = f"{algo}_total_time_heuristic_vs_heuristic_strong_mutex",
                outfile=f"{algo}/heuristic_vs_heuristic_strong_mutex_total_time.png"
            )
    
    # Strong Mutex
    if os.path.exists(os.path.join(SCRIPT_DIR, exp_with_s_m + "-eval")) and os.path.exists(os.path.join(SCRIPT_DIR, exp_with_h_with_s_m + "-eval")):
        exp.add_report(
            ScatterPlotReport(
                get_category=aggregate_domain_variants,
                attributes=["clingo_total_time"],
                filter_algorithm=[algo + "_strong_mutex", algo + "_heuristic_strong_mutex"],
                title="Clingo Time",
                show_missing=False,
                matplotlib_options={"legend.fontsize": 1}
            ),
            name = f"{algo}_clingo_strong_mutex_vs_heuristic_strong_mutex",
            outfile=f"{algo}/strong_mutex_vs_heuristic_strong_mutex_clingo_total_time.png"
        )
        exp.add_report(
            ScatterPlotReport(
                get_category=aggregate_domain_variants,
                attributes=["total_time"],
                filter_algorithm=[algo + "_strong_mutex", algo + "_heuristic_strong_mutex"],
                title="CPPDL + Clingo Time",
                show_missing=False,
                matplotlib_options={"legend.fontsize": 1}
            ),
            name = f"{algo}_total_time_strong_mutex_vs_heuristic_strong_mutex",
            outfile=f"{algo}/strong_mutex_vs_heuristic_strong_mutex_total_time.png"
        )

exp.run_steps()