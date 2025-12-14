import json
import os
from pathlib import Path

output = Path("output.json")
if not output.exists():
    raise FileNotFoundError(f"{output} not found.")

values = json.loads(output.read_text())["Call"][-1]["Witnesses"][0]["Value"]
if not values:
    raise ValueError("No values found in output.json.")

plan_path = Path(os.environ.get("TMPDIR", "/tmp")) / "plan.lp"
with plan_path.open("w") as f:
    for v in values:
        f.write(f"{v}.\n")