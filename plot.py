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
    errors = []
    algo_stats = {}
    for run_data in data.values():
        error = run_data.get("unexplained_errors", [])
        if error and isinstance(error,list):
            for err_msg in error:
                if err_msg not in errors and "driver.log" not in err_msg:
                    errors.append(err_msg)
                    print(error)
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
    normalized_result_matrix = np.zeros((len(algos), len(domains)))
    time_matrix = np.zeros((len(algos), len(domains)))
    for i, algo in enumerate(algos):
        for j, domain in enumerate(domains):
            result_matrix[i,j] = algo_stats[algo][domain]["results"]
            time_matrix[i,j] = np.mean(algo_stats[algo][domain]["times"])
            normalized_result_matrix[i,j] = result_matrix[i,j] / num_problems[domain]

    chunk_size = 10
    for chunk_idx in range(0, len(domains), chunk_size):
        chunk_domains = domains[chunk_idx:chunk_idx+chunk_size]
        chunk_result = result_matrix[:, chunk_idx:chunk_idx+chunk_size]
        chunk_normalized_result = normalized_result_matrix[:, chunk_idx:chunk_idx+chunk_size]
        fig, ax = plt.subplots(figsize=(12,6))
        im = ax.imshow(chunk_normalized_result, cmap='YlGn', aspect='auto')
        ax.set_xticks(range(len(chunk_domains)), labels=chunk_domains,
                    rotation=45, ha="right", rotation_mode="anchor")
        ax.set_yticks(range(len(algos)), labels=algos)
        for i in range(len(algos)):
            for j, d in enumerate(chunk_domains):
                text = ax.text(j, i, f"{chunk_result[i,j]} / {num_problems[d]}",
                            ha="center", va="center", color="black")
        ax.set_title(f"Solved instances (Part {chunk_idx//chunk_size + 1})")
        fig.tight_layout()
        plt.savefig(f"solved_part{chunk_idx//chunk_size + 1}.png")
        plt.close()

        chunk_time = time_matrix[:, chunk_idx:chunk_idx+chunk_size]
        non_zero_times = chunk_time[chunk_time > 0]
        vmin = non_zero_times.min() if len(non_zero_times) > 0 else 0.01
        vmax = non_zero_times.max() if len(non_zero_times) > 0 else 1
        
        fig2, ax2 = plt.subplots(figsize=(12,6))
        im = ax2.imshow(chunk_time, cmap='YlOrRd', aspect='auto', 
                        norm=plt.matplotlib.colors.LogNorm(vmin=max(vmin, 0.01), vmax=vmax))
        ax2.set_xticks(range(len(chunk_domains)), labels=chunk_domains,
                    rotation=45, ha="right", rotation_mode="anchor")
        ax2.set_yticks(range(len(algos)), labels=algos)
        for i in range(len(algos)):
            for j in range(len(chunk_domains)):
                text = ax2.text(j, i, f"{time_matrix[i,j]:.2f}s",
                            ha="center", va="center", color="black")
        ax2.set_title(f"Average Solving Time (Part {chunk_idx//chunk_size + 1})")
        fig2.tight_layout()
        plt.savefig(f"avg_time_part{chunk_idx//chunk_size + 1}.png")

    