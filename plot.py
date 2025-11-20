import matplotlib.pyplot as plt
import numpy as np
import os
import json

def create_heat_map(properties_file):
    data = {}
    try:
        if not os.path.exists(properties_file):
            raise FileNotFoundError
        with open(properties_file, 'r') as f:
            data = json.load(f)
    except (json.JSONDecodeError, IOError) as e:
            print(f"Error reading properties file: {e}")
    
    algo_stats = {}
    for run_data in data.values():
        algo = run_data.get("algorithm")
        domain = run_data.get("domain")
        time = run_data.get("clingo_total_time", 0)
        result = 1 if run_data.get("result", "UNKNOWN") != "UNKNOWN" else 0
        if algo not in algo_stats:
            algo_stats[algo] = {}

        if domain not in algo_stats[algo]:
            algo_stats[algo][domain] = {"results": 0, "times": []}

        
        algo_stats[algo][domain]["results"] += result
        algo_stats[algo][domain]["times"].append(time)
    algos = list(algo_stats.keys())
    domains = list(algo_stats[algos[0]].keys())
    num_problems = {}
    for d in algo_stats[algos[0]].keys():
        num_problems[d] = len(algo_stats[algos[0]][d]["times"])
    result_matrix = np.zeros((len(algos), len(domains)), dtype=int)
    time_matrix = np.zeros((len(algos), len(domains)))
    for i, algo in enumerate(algos):
        for j, domain in enumerate(domains):
            result_matrix[i,j] = algo_stats[algo][domain]["results"]
            time_matrix[i,j] = np.mean(algo_stats[algo][domain]["times"])

    fig, ax = plt.subplots()
    #im = ax.imshow(result_matrix)
    ax.set_xticks(range(len(domains)), labels=domains,
                rotation=45, ha="right", rotation_mode="anchor")
    ax.set_yticks(range(len(algos)), labels=algos)

    for i in range(len(algos)):
        for j, d in enumerate(domains):
            text = ax.text(j, i, f"{result_matrix[i,j]} / {num_problems[d]}",
                        ha="center", va="center", color="w")

    ax.set_title("Solved instances")
    fig.tight_layout()
    plt.savefig("solved.png")
    fig2, ax2 = plt.subplots()
    #im2 = ax2.imshow(time_matrix)
    ax2.set_xticks(range(len(domains)), labels=domains,
                rotation=45, ha="right", rotation_mode="anchor")
    ax2.set_yticks(range(len(algos)), labels=algos)

    for i in range(len(algos)):
        for j in range(len(domains)):
            text = ax2.text(j, i, f"{time_matrix[i,j]:.2f}s",
                        ha="center", va="center", color="w")

    ax2.set_title("Average Solving Time per Algorithm and Domain")
    fig2.tight_layout()
    plt.savefig("avg_time.png")

    