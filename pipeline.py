#!/usr/bin/env python3

import subprocess
import sys
import re
from pathlib import Path


def shorten_output(output):
    '''Omit *%Solving* message from clingo output'''
    if "ANSWER" in output:
        return output.split("ANSWER")[-1].strip()
    elif "INCONSISTENT" in output:
        return output.split("INCONSISTENT")[-1].strip()
    else:
        return None


def get_model(output):
    return output.split("\n")[0].strip()


def get_times(output):
    return "\n".join(output.split("\n")[1:])


def get_plan_length(plan):
    return 0 if plan is None else int(plan[-3])


def run_clingo(script_dir, temp_path, algo, time_limit, heuristic):
    output = Path(f"{temp_path}/output.lp")
    if not output.exists() or output.stat().st_size == 0:
        return None
    
    cmd = [
        f"{script_dir}/../clingo/clingo",
        "--outf=1",
        f"--time-limit={time_limit}"
    ]
    
    if "guess_and_check" in algo:
        cmd.append(f"{script_dir}/algorithms/guess.lp")
    else:
        cmd.extend([f"{script_dir}/algorithms/common.lp", algo])
    
    cmd.append(f"{temp_path}/output.lp")
    if heuristic:
        cmd.append(f"{script_dir}/algorithms/heuristic.lp")
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.stderr:
        print(result.stderr, file=sys.stderr)
    return shorten_output(result.stdout)


def run_check(script_dir, temp_path, plan, plan_length):
    if "occurs" not in plan.read_text():
        return None

    cmd = [
        f"{script_dir}/../clingo/clingo",
        "--outf=1",
        f"--time-limit=800",
        plan,
        f"{script_dir}/algorithms/check.lp",
        f"{temp_path}/output.lp",
        "-c", f"imax={plan_length}"
    ]
    
    result = subprocess.run(cmd, text=True, capture_output=True)
    if result.stderr:
        print(result.stderr, file=sys.stderr)
    return shorten_output(result.stdout)


def run_to_parallel(script_dir, temp_path, plan):
    if not plan:
        return None
    
    cmd = [
        f"{script_dir}/../clingo/clingo",
        "--outf=1",
        plan,
        f"{script_dir}/algorithms/parallel_to_sequential.lp",
        f"{temp_path}/output.lp"
    ]
    
    result = subprocess.run(cmd, text=True, capture_output=True)
    if result.stderr:
        print(result.stderr, file=sys.stderr)
    return get_model(shorten_output(result.stdout))


def occurs2sas(plan_path: str, temp_path: str):
    actions = plan_path.read_text() if plan_path.exists() else ""
    matches = re.findall(r'\(action\((.+?)\),(\d+)\)', actions)
    pairs = []
    for action_content, timestep in matches:
        args = re.findall(r'"([^"]+)"', action_content)
        pairs.append((timestep, args))
    sas_plan = Path(f"{temp_path}/sas_plan")
    with sas_plan.open("w") as f:
        for t, args in pairs:
            f.write(f"{t}: ({' '.join(args)})\n")


def main():
    if len(sys.argv) < 5:
        sys.exit(1)
    
    script_dir = sys.argv[1]
    temp_path = sys.argv[2]
    algo = sys.argv[3]
    time_limit = int(sys.argv[4])
    heuristic = sys.argv[5].lower() == "true"
    
    # Step 1: Solve/Guess
    clingo_output = run_clingo(script_dir, temp_path, algo, time_limit, heuristic)
    
    if clingo_output is None:
        return
    
    plan_text = get_model(clingo_output)
    plan = Path(f"{temp_path}/plan.lp")
    with plan.open("w") as f:
            f.write(plan_text)

    # Step 2: Check (only for guess)
    if "guess_and_check" in algo:
        plan_length = get_plan_length(plan_text)
        check_output = run_check(script_dir, temp_path, plan, plan_length)
        if check_output:
            print("GUESS")
            print(get_times(clingo_output))
            print("CHECK")
            print(get_times(check_output))
        else:
            return
    
    else:
        print(get_times(clingo_output))
    # Step 3: convert to sequential plan
    seq_plan = run_to_parallel(script_dir, temp_path, plan)
    if seq_plan:
        with open(f"{temp_path}/seq_plan.lp", "w") as f:
            f.write(seq_plan)
    else:
        return
    
    # Step 4: convert to sas plan
    occurs2sas(Path(f"{temp_path}/seq_plan.lp"), temp_path)

if __name__ == "__main__":
    main()