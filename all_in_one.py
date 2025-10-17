import argparse
import os
import subprocess

def create_sas_file(problem, domain):
    fd_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "../downward/fast-downward.py")
    result = subprocess.run(["python3", fd_path, "--translate", domain, problem], capture_output=True, text=True)
    print(result.stdout)

def translate_with_plasp():
    result = subprocess.run(["./plasp/build/release/bin/plasp", "translate", "output.sas"], capture_output= True, text=True)
    with open("test.lp", "a") as f:
        f.write(result.stdout)


parser = argparse.ArgumentParser(prog="all_in_one.py")
parser.add_argument("domain")
parser.add_argument("problem")
parser_args = parser.parse_args()
domain = parser_args.domain
problem = parser_args.problem
create_sas_file(problem, domain)
translate_with_plasp()
