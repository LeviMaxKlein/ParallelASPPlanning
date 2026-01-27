import matplotlib.pyplot as plt
import numpy as np
import os
import json

def get_algo_stats(data):
    results = {}
    problem_solutions = {} # {(domain, problem): {algo: time}}
    num_problems = {}
    for run_data in data.values():
        algo = run_data.get("algorithm")
        domain = run_data.get("domain")
        grouped_domain = domain.split("-")[0]
        problem = run_data.get("problem")
        result = run_data.get("solved", 0)
        time = run_data.get("clingo_total_time", 0) if result == 1 else 0

        # Count and store solved instances per algorithm and grouped domain
        if algo not in results:
            results[algo] = {}
        if grouped_domain not in results[algo]:
            results[algo][grouped_domain] = 0
        results[algo][grouped_domain] += result

        # Store individual problem solutions
        key = (domain, problem)
        if key not in problem_solutions:
            problem_solutions[key] = {}
        if result == 1:
            problem_solutions[key][algo] = time

    # Count number of problems per grouped domain
    for (domain, _) in problem_solutions.keys():
        grouped_domain = domain.split("-")[0]
        if grouped_domain not in num_problems:
            num_problems[grouped_domain] = 0
        num_problems[grouped_domain] +=1

    return results, problem_solutions, num_problems


def filter_grouped_domains(results: dict, algos: list):
    domains_to_keep = set()
    all_domains = set()
    for algo in algos:
        if algo in results:
            all_domains.update(results[algo].keys())
    
    for domain in all_domains:
        has_solution = False
        for algo in algos:
            if algo in results and domain in results[algo] and results[algo][domain] > 0:
                has_solution = True
                break
        if has_solution:
            domains_to_keep.add(domain)
    return domains_to_keep


def filter_times(problem_solutions: dict, algos: list):
    """
    Filter times to include only problems solved by the algorithms given in ``algos``.
    """
    filtered_times = {algo: {} for algo in algos}
    for (domain, _), algos_and_times in problem_solutions.items():
        grouped_domain = domain.split("-")[0]
        if len(algos_and_times) == len(algos):
            for algo in algos:
                if algo in algos_and_times:
                    if grouped_domain not in filtered_times[algo]:
                        filtered_times[algo][grouped_domain] = []
                    filtered_times[algo][grouped_domain].append(algos_and_times[algo])
    return filtered_times


def create_matrices(algo_stats, filtered_times, algos, domains, num_problems):
    result_matrix = np.zeros((len(algos), len(domains)), dtype=int)
    normalized_result_matrix = np.zeros((len(algos), len(domains)))
    time_matrix = np.full((len(algos), len(domains)), np.nan)
    for row, algo in enumerate(algos):
        for col, domain in enumerate(domains):
            result_matrix[row,col] = algo_stats[algo][domain]
            normalized_result_matrix[row,col] = result_matrix[row,col] / num_problems[domain]
            if domain in filtered_times[algo]:
                time_matrix[row,col] = np.mean(filtered_times[algo][domain])
            else:
                time_matrix[row,col] = np.nan
    return result_matrix, normalized_result_matrix, time_matrix


def create_heat_map(exp_path):
    properties_file = os.path.join(exp_path, "properties")
    data = {}
    try:
        if not os.path.exists(properties_file):
            raise FileNotFoundError
        with open(properties_file, 'r') as f:
            data = json.load(f)
    except (json.JSONDecodeError, IOError) as e:
            print(f"Error reading properties file: {e}")
    
    results, problem_solutions, num_problems = get_algo_stats(data)
    algos = list(results.keys())
    domains = list(filter_grouped_domains(results, algos))

    filtered_times = filter_times(problem_solutions, algos)
    result_matrix, normalized_result_matrix, time_matrix = create_matrices(results, filtered_times, algos, domains, num_problems)

    chunk_size = 10
    for chunk_idx in range(0, len(domains), chunk_size):
        # heatmap for solved instances
        chunk_domains = domains[chunk_idx:chunk_idx+chunk_size]
        chunk_result = result_matrix[:, chunk_idx:chunk_idx+chunk_size]
        chunk_normalized_result = normalized_result_matrix[:, chunk_idx:chunk_idx+chunk_size]
        fig, ax = plt.subplots(figsize=(12,6))
        _ = ax.imshow(chunk_normalized_result, cmap='YlGn', aspect='auto')
        ax.set_xticks(range(len(chunk_domains)), labels=chunk_domains,
                    rotation=45, ha="right", rotation_mode="anchor")
        ax.set_yticks(range(len(algos)), labels=algos)
        for i in range(len(algos)):
            for j, d in enumerate(chunk_domains):
                _ = ax.text(j, i, f"{chunk_result[i,j]} / {num_problems[d]}",
                            ha="center", va="center", color="black")
        ax.set_title(f"Solved instances (Part {chunk_idx//chunk_size + 1})")
        fig.tight_layout()
        plt.savefig(f"{exp_path}/solved_part{chunk_idx//chunk_size + 1}.png")
        plt.close()

        # heatmap for average solving time
        chunk_time = time_matrix[:, chunk_idx:chunk_idx+chunk_size]
        non_zero_times = chunk_time[~np.isnan(chunk_time)]
        if len(non_zero_times) > 0:
            vmin = non_zero_times.min()
            vmax = non_zero_times.max()
            norm = plt.matplotlib.colors.LogNorm(vmin=max(vmin, 0.0001), vmax=vmax)
        else:
            # If all values are NaN, use dummy values
            norm = plt.matplotlib.colors.Normalize(vmin=0, vmax=1)
        
        fig2, ax2 = plt.subplots(figsize=(12,6))
        _ = ax2.imshow(chunk_time, cmap='YlOrRd', aspect='auto', 
                       norm=norm)
        ax2.set_xticks(range(len(chunk_domains)), labels=chunk_domains,
                    rotation=45, ha="right", rotation_mode="anchor")
        ax2.set_yticks(range(len(algos)), labels=algos)
        for i in range(len(algos)):
            for j in range(len(chunk_domains)):
                if np.isnan(chunk_time[i,j]):
                    text = ax2.text(j, i, "None", ha="center", va="center", color="black")
                else:
                    text = ax2.text(j, i, f"{chunk_time[i,j]:.2f}s",
                                    ha="center", va="center", color="black")
        ax2.set_title(f"Average Solving Time (Part {chunk_idx//chunk_size + 1})")
        fig2.tight_layout()
        plt.savefig(f"{exp_path}/avg_time_part{chunk_idx//chunk_size + 1}.png")
        plt.close()
