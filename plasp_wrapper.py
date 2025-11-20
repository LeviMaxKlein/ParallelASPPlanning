import subprocess
import sys
from pathlib import Path

if not Path("output.sas").is_file():
    sys.exit(1)

with open("output.lp", "w") as f:
    result = subprocess.run(["../../../../../plasp", "translate", "output.sas"], stdout= f)
sys.exit(result.returncode)