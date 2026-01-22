#!/usr/bin/env python3

import subprocess
import sys
import re
from pathlib import Path

def shorten_output(output):
    '''Omit *%Solving* message from clingo output'''
    if "ANSWER" in output:
        if "cycle" in output:
            print("Check failed")
            return None
        else:
            return output.split("ANSWER")[-1].strip()
    elif "INCONSISTENT" in output:
        return output.split("INCONSISTENT")[-1].strip()
    else:
        return None


def get_model(shorten_output):
    return shorten_output.split("\n")[0].strip()


def get_stats(shorten_output):
    return "\n".join(shorten_output.split("\n")[1:])


def sum_stats(guess_stat, check_stat):
    guess_time = re.search(r'Time\s*:\s*([\d.]+)s', guess_stat)
    guess_solving = re.search(r'Solving:\s*([\d.]+)s', guess_stat)
    guess_first = re.search(r'1st Model:\s*([\d.]+)s', guess_stat)
    guess_unsat = re.search(r'Unsat:\s*([\d.]+)s', guess_stat)
    guess_cpu = re.search(r'CPU Time\s*:\s*([\d.]+)s', guess_stat)
    
    check_models = re.search(r'Models\s*:\s*(\d+)', check_stat)
    check_time = re.search(r'Time\s*:\s*([\d.]+)s', check_stat)
    check_solving = re.search(r'Solving:\s*([\d.]+)s', check_stat)
    check_first = re.search(r'1st Model:\s*([\d.]+)s', check_stat)
    check_unsat = re.search(r'Unsat:\s*([\d.]+)s', check_stat)
    check_cpu = re.search(r'CPU Time\s*:\s*([\d.]+)s', check_stat)
    
    total_time = float(guess_time.group(1)) + float(check_time.group(1))
    total_solving = float(guess_solving.group(1)) + float(check_solving.group(1))
    total_first = float(guess_first.group(1)) + float(check_first.group(1))
    total_unsat = float(guess_unsat.group(1)) + float(check_unsat.group(1))
    total_cpu = float(guess_cpu.group(1)) + float(check_cpu.group(1))
    lines = [
        f"% Models         : {check_models.group(1)}",
        f"% Guess Time     : {float(guess_time.group(1)):.3f}s",
        f"% Time           : {total_time:.3f}s (Solving: {total_solving:.2f}s 1st Model: {total_first:.2f}s Unsat: {total_unsat:.2f}s)",
        f"% CPU Time       : {total_cpu:.3f}s"
    ]
    return "\n".join(lines)


def get_plan_length(plan):
    return 0 if plan is None else int(plan[-3])


def run_cpddl(script_dir, time_limit, temp_path, domain, problem, strong_mutex):
    cpddl_command = [f"{script_dir}/../cpddl/bin/pddl"]
    if strong_mutex:
        cpddl_command.extend(["--h2", "--P-h2fwbw-time-limit", str(time_limit)])
    cpddl_command.extend(["--fdr-out", f"{temp_path}/output.sas", domain, problem])

    result = subprocess.run(cpddl_command, capture_output=True, text=True)
    if result.stderr:
        print(result.stderr, file=sys.stderr)

def run_plasp(script_dir, temp_path):
    if not Path(f"{temp_path}/output.sas").exists():
        return None
    subprocess.run([f"{script_dir}/../plasp translate {temp_path}/output.sas > {temp_path}/output.lp"],
                    capture_output=True, text=True, shell=True)


def run_clingo(script_dir, time_limit, temp_path, algo, heuristic):
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


def run_parallel_to_seq(script_dir, temp_path, plan):
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


def convert_occurs_to_sas_plan(plan_path: str, temp_path: str):
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
    if len(sys.argv) < 9:
        sys.exit(1)
    
    script_dir = sys.argv[1]
    time_limit = sys.argv[2]
    temp_path = sys.argv[3]
    domain = sys.argv[4]
    problem = sys.argv[5]
    algo = sys.argv[6]
    strong_mutex = sys.argv[7].lower() == "true"
    heuristic = sys.argv[8].lower() == "true"

    # Step 1: Translate PDDL to ASP
    run_cpddl(script_dir, time_limit, temp_path, domain, problem, strong_mutex)
    run_plasp(script_dir, temp_path)
    
    # Step 2: Solve/Guess
    clingo_output = run_clingo(script_dir, time_limit, temp_path, algo, heuristic)
    
    if clingo_output is None:
        return
    
    plan_text = get_model(clingo_output)
    plan = Path(f"{temp_path}/plan.lp")
    with plan.open("w") as f:
            f.write(plan_text)

    # Step 3: Check (only for guess)
    if "guess_and_check" in algo:
        plan_length = get_plan_length(plan_text)
        check_output = run_check(script_dir, temp_path, plan, plan_length)
        if check_output:
            print(sum_stats(get_stats(clingo_output), get_stats(check_output)))
        else:
            return
    
    else:
        print(get_stats(clingo_output))
    # Step 4: convert to sequential plan
    seq_plan = run_parallel_to_seq(script_dir, temp_path, plan)
    if seq_plan:
        with open(f"{temp_path}/seq_plan.lp", "w") as f:
            f.write(seq_plan)
    else:
        return
    
    # Step 5: convert to sas plan
    convert_occurs_to_sas_plan(Path(f"{temp_path}/seq_plan.lp"), temp_path)

if __name__ == "__main__":
    main()