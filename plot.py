import matplotlib.pyplot as plt
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

    algo_stat = {}
    for _, run_data in data.items():
        algo = run_data.get("algorithm")
        solved = run_data.get("solved", 0)
        if algo:
            if algo not in algo_stat:
                algo_stat[algo] = {"solved": 0, "total": 0}
            algo_stat[algo]["total"] += 1
            algo_stat[algo]["solved"] += solved
    print(algo_stat)
    algos = list(algo_stat.keys())
    solved_counts = [algo_stat[alg]["solved"] for alg in algos]
    total_counts = [algo_stat[alg]["total"] for alg in algos]
    heatmap_data = []
    for alg in algos:
        solved = algo_stat[alg]["solved"]
        unsolved = algo_stat[alg]["total"] - solved
        heatmap_data.append([solved, unsolved])

    fig, ax = plt.subplots(figsize=(8, 6))
    im = ax.imshow(heatmap_data, cmap='hot', aspect='auto')
    ax.set_xticks([0, 1])
    ax.set_xticklabels(['Solved', 'Unsolved'])
    ax.set_yticks(range(len(algos)))
    ax.set_yticklabels(algos)
    for i in range(len(algos)):
        for j in range(2):
            text = ax.text(j, i, int(heatmap_data[i] [j]),
                          ha="center", va="center", color="black", fontsize=12)
    plt.show()
