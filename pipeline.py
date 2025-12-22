#!/usr/bin/env python3
"""
Clingo Pipeline: Führt die Clingo-Solver-Sequenz aus
"""
import subprocess
import sys
from pathlib import Path

def run_clingo(script_dir, temp_path, algo, time_limit, with_heuristic):
    """Hauptsolving: Clingo mit Algorithmus"""
    cmd = [
        f"{script_dir}/../clingo/clingo",
        "--outf=1",
        f"--time-limit={time_limit}"
    ]
    
    if algo == "guess":
        cmd.append(f"{{{algo}}}")
    else:
        cmd.extend([f"{script_dir}/algorithms/common.lp", f"{{{algo}}}"])
    
    cmd.append(f"{temp_path}/output.lp")
    
    if with_heuristic:
        cmd.append(f"{script_dir}/algorithms/heuristic.lp")
    
    result = subprocess.run(cmd, capture_output=True, text=True)
    return extract_result(result.stdout)

def extract_result(output):
    """Extrahiere ANSWER aus Clingo-Output"""
    if "ANSWER" in output:
        return output.split("ANSWER")[-1].strip()
    return None

def extract_answer(output):
    return output.split("\n")[0].strip()

def run_check(script_dir, temp_path, model):
    """Validiere Plan mit check-Algorithmus (nur für guess)"""
    if not model:
        return None

    cmd = [
        f"{script_dir}/../clingo/clingo",
        "--outf=1",
        model,
        f"{script_dir}/algorithms/check.lp",
        f"{temp_path}/output.lp"
    ]
    
    result = subprocess.run(cmd, text=True, capture_output=True)
    return extract_result(result.stdout)

def run_to_parallel(script_dir, temp_path, model):
    """Konvertiere parallelen Plan zu sequenziellem Plan"""
    if not model:
        return None
    
    cmd = [
        f"{script_dir}/../clingo/clingo",
        "--outf=1",
        model,
        f"{script_dir}/algorithms/parallel_to_sequential.lp",
        f"{temp_path}/output.lp"
    ]
    
    result = subprocess.run(cmd, text=True, capture_output=True)
    return extract_result(result.stdout)

def main():
    if len(sys.argv) < 5:
        sys.exit(1)
    
    script_dir = sys.argv[1]
    temp_path = sys.argv[2]
    algo = sys.argv[3]
    time_limit = int(sys.argv[4])
    with_heuristic = sys.argv[5].lower() == "true" if len(sys.argv) > 5 else False
    
    # Step 1: Hauptsolving
    clingo_output = run_clingo(script_dir, temp_path, algo, time_limit, with_heuristic)
    
    if not clingo_output:
        return
    
    model = extract_answer(clingo_output)
    # Step 2: Check (nur für guess)
    if algo == "guess":
        check_output = run_check(script_dir, temp_path, model)
        if check_output:
            output = check_output
            print(f"ANSWER\n{model}")
        else:
            return
    
    # Step 3: Zu sequenziellem Plan konvertieren
    seq_plan = run_to_parallel(script_dir, temp_path, model)
    
    if seq_plan:
        with open("seq_plan.lp", "w") as f:
            f.write(seq_plan)
        print(f"Sequential plan written to seq_plan.lp", file=sys.stderr)
    else:
        Path("seq_plan.lp").touch()
        print("Could not convert to sequential plan", file=sys.stderr)

if __name__ == "__main__":
    main()