from pathlib import Path
import re
import sys

plan = Path("seq_plan.lp")

actions = plan.read_text() if plan.exists() else ""

matches = re.findall(r'\(action\((.+?)\),(\d+)\)', actions)

pairs = []
for action_content, timestep in matches:
    args = re.findall(r'"([^"]+)"', action_content)
    pairs.append((timestep, args))

sas_plan = Path("sas_plan")
with sas_plan.open("w") as f:
    for t, args in pairs:
        f.write(f"{t}: ({' '.join(args)})\n")