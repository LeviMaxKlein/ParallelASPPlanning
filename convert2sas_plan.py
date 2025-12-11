import json
import os
import re
from pathlib import Path

seq_path = Path(os.environ.get("TMPDIR", "/tmp")) / "sequential.json"
if not seq_path.exists():
    raise FileNotFoundError(f"{seq_path} not found.")

values = json.loads(seq_path.read_text())["Call"][-1]["Witnesses"][0]["Value"]
if not values:
    raise ValueError("No values found in sequential.json.")

sas_plan = Path(os.environ.get("TMPDIR", "/tmp")) / "sas_plan"
with sas_plan.open("w") as f:
    for value in values:
        strings = re.findall(r'"([^"]*)"', value)
        time_match = re.search(r'\),(\d+)\)$', value)
        timestep = int(time_match.group(1)) if time_match else 0
        f.write(f"{timestep}:" + "(" + " ".join(strings) + ")" + "\n")