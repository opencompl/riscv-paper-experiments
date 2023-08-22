import pytest
import subprocess
import os

def execute(cmd, cwd):
    # Executes and immediately prints
    def command(cmd, cwd):
        popen = subprocess.Popen(cmd, stdout=subprocess.PIPE, universal_newlines=True, cwd=cwd)
        for stdout_line in iter(popen.stdout.readline, ""):
            yield stdout_line
        popen.stdout.close()
        return_code = popen.wait()
        if return_code:
            raise subprocess.CalledProcessError(return_code, cmd)
    for line in command(cmd, cwd):
        print(line, end="")


@pytest.mark.parametrize("example", ["addf", "echo"])
def test_examples(example):
    print(example)
    directory = os.getcwd() + "/examples/" + example
    execute(["make", "clean"], directory)
    execute(["make"], directory)
    execute(["make", "run"], directory)

