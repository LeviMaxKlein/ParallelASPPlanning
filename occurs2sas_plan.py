import os
from pathlib import Path
import re

plan = Path(os.environ.get("TMPDIR", "/tmp")) / "plan.lp"
if not plan.exists():
    raise FileNotFoundError(f"{plan} not found.")

lines = plan.read_text().splitlines()
sas_plan = Path(os.environ.get("TMPDIR", "/tmp")) / "sas_plan"
with sas_plan.open("w") as f:
    for line in lines:
        match = re.search(r'occurs\(action\(\(([^)]+)\)\),(\d+)\)', line)
        if match:
            action_args = match.group(1)
            timestep = match.group(2)
            args = [arg.strip().strip('"') for arg in action_args.split(",")]
            f.write(f"{timestep}:(" + " ".join(args) +")\n")