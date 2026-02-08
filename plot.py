import matplotlib.pyplot as plt
import numpy as np
import os
import json

def get_algo_stats(data):
    results = {}
    problem_solutions = {} # {(domain, problem): {algo: time}}
    guess_check_times = {}
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

            if algo == "guess_and_check":
                guess_time = run_data.get("clingo_guess_time", 0)
                failed_check = run_data.get("failed_check", 0)
                
                if key not in guess_check_times:
                    guess_check_times[key] = {}
                
                if guess_time != 0:
                    if failed_check > 0:
                        # Check failed -> fallback to forall
                        forall_time = time - guess_time
                        guess_check_times[key] = {
                            'guess': guess_time,
                            'check': 0,
                            'forall': forall_time
                        }
                    else:
                        # Check succeeded
                        check_time = time - guess_time
                        guess_check_times[key] = {
                            'guess': guess_time,
                            'check': check_time,
                            'forall': 0
                        }
                else:
                    # No guess time recorded
                    guess_check_times[key] = {
                        'guess': 0,
                        'check': 0,
                        'forall': 0
                    }


    # Count number of problems per grouped domain
    for (domain, _) in problem_solutions.keys():
        grouped_domain = domain.split("-")[0]
        if grouped_domain not in num_problems:
            num_problems[grouped_domain] = 0
        num_problems[grouped_domain] +=1


    return results, problem_solutions, num_problems, guess_check_times


def filter_guess_check_times(guess_check_times: dict, domains: list):
    """
    Filter guess and check times for baseline guess_and_check algorithm.
    Returns average guess, check, and forall times per domain.
    """
    filtered_guess_check = {}
    
    for (domain, _), times in guess_check_times.items():
        grouped_domain = domain.split("-")[0]
        if grouped_domain not in filtered_guess_check:
            filtered_guess_check[grouped_domain] = {
                'guess': [],
                'check': [],
                'forall': []
            }
        filtered_guess_check[grouped_domain]['guess'].append(times['guess'])
        filtered_guess_check[grouped_domain]['check'].append(times['check'])
        filtered_guess_check[grouped_domain]['forall'].append(times['forall'])
    
    # Calculate averages
    avg_guess_check = {}
    for domain in filtered_guess_check:
        avg_guess_check[domain] = {
            'avg_guess': np.mean(filtered_guess_check[domain]['guess']),
            'avg_check': np.mean(filtered_guess_check[domain]['check']),
            'avg_forall': np.mean(filtered_guess_check[domain]['forall'])
        }
    
    return avg_guess_check


def create_guess_check_heatmap(avg_guess_check, domains, exp_path):
    """Create heatmap with guess, check, and forall times as separate rows."""
    if not avg_guess_check:
        return
    
    # Create matrix with 3 rows (guess, check, forall) and columns for domains
    time_matrix = np.full((3, len(domains)), np.nan)
    
    for j, domain in enumerate(domains):
        if domain in avg_guess_check:
            time_matrix[0, j] = avg_guess_check[domain]['avg_guess']
            time_matrix[1, j] = avg_guess_check[domain]['avg_check']
            time_matrix[2, j] = avg_guess_check[domain]['avg_forall']
    
    # Filter out domains with no data
    valid_cols = ~np.all(np.isnan(time_matrix), axis=0)
    filtered_domains = [d for d, valid in zip(domains, valid_cols) if valid]
    filtered_time_matrix = time_matrix[:, valid_cols]
    
    if filtered_time_matrix.size == 0:
        return
    
    fig, ax = plt.subplots(figsize=(16, 4))
    non_zero_times = filtered_time_matrix[~np.isnan(filtered_time_matrix)]
    non_zero_times = non_zero_times[non_zero_times > 0]  # Exclude zeros
    
    if len(non_zero_times) > 0:
        norm = plt.matplotlib.colors.LogNorm(vmin=max(non_zero_times.min(), 0.0001), 
                                            vmax=non_zero_times.max())
    else:
        norm = plt.matplotlib.colors.Normalize(vmin=0, vmax=1)
    
    im = ax.imshow(filtered_time_matrix, cmap='YlOrRd', aspect='auto', norm=norm)
    ax.set_xticks(range(len(filtered_domains)), labels=filtered_domains,
                  rotation=45, ha="right", rotation_mode="anchor")
    ax.set_yticks([0, 1, 2], labels=["Guess\nTime", "Check\nTime", r"$\forall$ Time"])
    
    # Add text annotations
    for i in range(3):
        for j in range(len(filtered_domains)):
            if not np.isnan(filtered_time_matrix[i, j]):
                val = filtered_time_matrix[i, j]
                if val == 0:
                    ax.text(j, i, "-", ha="center", va="center", color="gray", fontsize=8)
                else:
                    ax.text(j, i, f"{val:.2f}s", ha="center", va="center", color="black", fontsize=6)
    
    fig.tight_layout()
    plt.savefig(f"{exp_path}/avg_guess_check_forall_time.png", dpi=150)
    plt.close()
    

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


def filter_times(problem_solutions: dict, algos: list, disable=False):
    """
    Filter times to include only problems solved by the algorithms given in ``algos``.
    """
    filtered_times = {algo: {} for algo in algos}
    for (domain, _), algos_and_times in problem_solutions.items():
        grouped_domain = domain.split("-")[0]
        if len(algos_and_times) == len(algos) or disable:
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
    
    results, problem_solutions, num_problems, guess_check_times = get_algo_stats(data)
    algo_order = ["sequential", "forall", "exists", "exists_edge", "relaxed", "guess_and_check"]
    algos = [algo for algo in algo_order if algo in results]
    domains = sorted(list(filter_grouped_domains(results, algos)))

    algo_labels = {
        "forall": r"$\forall$",
        "exists": r"$\exists$",
        "exists_edge": "E",
        "relaxed": "R",
        "sequential": "S",
        "guess_and_check": "G&C"
    }
    display_algos = [algo_labels.get(algo, algo) for algo in algos]

    filtered_times = filter_times(problem_solutions, algos, disable=False)
    result_matrix, normalized_result_matrix, time_matrix = create_matrices(results, filtered_times, algos, domains, num_problems)

    if guess_check_times:
        avg_guess_check = filter_guess_check_times(guess_check_times, domains)
        create_guess_check_heatmap(avg_guess_check, domains, exp_path)


    not_nan_cols = ~np.all(np.isnan(time_matrix), axis=0)
    time_domains = [d for d, not_nan in zip(domains, not_nan_cols) if not_nan]
    filtered_time_matrix = time_matrix[:, not_nan_cols]

    chunk_size = 20
    for chunk_idx in range(0, len(domains), chunk_size):
        # heatmap for solved instances
        chunk_domains = domains[chunk_idx:chunk_idx+chunk_size]
        chunk_result = result_matrix[:, chunk_idx:chunk_idx+chunk_size]
        chunk_normalized_result = normalized_result_matrix[:, chunk_idx:chunk_idx+chunk_size]
        fig, ax = plt.subplots(figsize=(16,5))
        _ = ax.imshow(chunk_normalized_result, cmap='YlGn', aspect='auto')
        ax.set_xticks(range(len(chunk_domains)), labels=chunk_domains,
                    rotation=45, ha="right", rotation_mode="anchor")
        ax.set_yticks(range(len(algos)), labels=display_algos)
        for i in range(len(algos)):
            for j, d in enumerate(chunk_domains):
                _ = ax.text(j, i, f"{chunk_result[i,j]} / {num_problems[d]}",
                            ha="center", va="center", color="black", fontsize=9)
        #ax.set_title(f"Solved instances (Part {chunk_idx//chunk_size + 1})")
        fig.tight_layout()
        plt.savefig(f"{exp_path}/solved_part{chunk_idx//chunk_size + 1}.png")
        plt.close()

    for chunk_idx in range(0, len(time_domains), chunk_size):
        # heatmap for average solving time
        chunk_time_domains = time_domains[chunk_idx:chunk_idx+chunk_size]
        chunk_time = filtered_time_matrix[:, chunk_idx:chunk_idx+chunk_size]
        non_zero_times = chunk_time[~np.isnan(chunk_time)]
        if len(non_zero_times) > 0:
            vmin = non_zero_times.min()
            vmax = non_zero_times.max()
            norm = plt.matplotlib.colors.LogNorm(vmin=max(vmin, 0.0001), vmax=vmax)
        else:
            # If all values are NaN, use dummy values
            norm = plt.matplotlib.colors.Normalize(vmin=0, vmax=1)
        
        fig2, ax2 = plt.subplots(figsize=(16,5))
        _ = ax2.imshow(chunk_time, cmap='YlOrRd', aspect='auto', 
                       norm=norm)
        ax2.set_xticks(range(len(chunk_time_domains)), labels=chunk_time_domains,
                    rotation=45, ha="right", rotation_mode="anchor")
        ax2.set_yticks(range(len(algos)), labels=display_algos)
        for i in range(len(algos)):
            for j in range(len(chunk_time_domains)):
                if np.isnan(chunk_time[i,j]):
                    text = ax2.text(j, i, "None", ha="center", va="center", color="black")
                else:
                    text = ax2.text(j, i, f"{chunk_time[i,j]:.2f}s",
                                    ha="center", va="center", color="black")
        fig2.tight_layout()
        plt.savefig(f"{exp_path}/avg_time_part{chunk_idx//chunk_size + 1}.png")
        plt.close()
