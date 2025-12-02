import json
import re
import os
from pathlib import Path


data = {}
try:
    if not os.path.exists("output.json"):
        raise FileNotFoundError
    with open("output.json", 'r') as f:
        data = json.load(f)
except (json.JSONDecodeError, IOError) as e:
        print(f"Error reading properties file: {e}")
values = data["Call"][-1]["Witnesses"][0]["Value"]
with open("plan.lp", "w") as f:
    for value in values:
        f.write(f"{value}.\n")