import json
import os
from pathlib import Path

clingo_output_file = Path("output.json")
if not clingo_output_file.exists():
    raise FileNotFoundError(f"{clingo_output_file} not found.")

values = json.loads(clingo_output_file.read_text())["Call"][-1]["Witnesses"][0]["Value"]
if not values:
    raise ValueError("No values found in output.json.")

plan_path = "plan.lp"
with plan_path.open("w") as f:
    for v in values:
        f.write(f"{v}.\n")