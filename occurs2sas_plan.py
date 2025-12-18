from pathlib import Path
import re
import sys

plan = Path("seq_plan.lp")

actions = plan.read_text() if plan.exists() else ""

matches = re.findall(r'\(action\(\(([^)]+)\)\),(\d+)\)', actions)

pairs = []
for action_args, timestep in matches:
    args = [arg.strip().strip('"') for arg in action_args.split(",")]
    t = int(timestep)
    pairs.append((t, args))

sas_plan = Path("sas_plan")
with sas_plan.open("w") as f:
    for t, args in pairs:
        f.write(f"{t}: ({' '.join(args)})\n")