import json
import re
import os
from pathlib import Path


data = {}
try:
    if not os.path.exists("sequential.json"):
        raise FileNotFoundError
    with open("sequential.json", 'r') as f:
        data = json.load(f)
except (json.JSONDecodeError, IOError) as e:
        print(f"Error reading properties file: {e}")
values = data["Call"][-1]["Witnesses"][0]["Value"]
actions = []
with open("sas_plan", "w") as f:
    for value in values:
        strings = re.findall(r'"([^"]*)"', value)
        time_match = re.search(r'\),(\d+)\)$', value)
        timestep = int(time_match.group(1)) if time_match else 0
        f.write(f"{timestep}:" + "(" + " ".join(strings) + ")" + '\n')