#!/usr/bin/env python3

import argparse
import json
import sys
import subprocess
import contextlib
from os import path

# Default profile section that refers to each kernel hot part
DEFAULT_SECTION = 1

# How many elements we expect in the profile file.
# If we don't find EXPECTED_N_SECTIONS something sketchy
# is going on so better to error out than risking to add
# the wrong profile in the end results
EXPECTED_N_SECTIONS = 3

FPSS_FPU_FMADD_ISSUES_EXE = path.abspath(
    path.join(path.dirname(__file__), "fpss_fpu_fmadd_issues.awk")
)


@contextlib.contextmanager
def open_output_stream(filename=None):
    if filename and filename != "-":
        f = open(filename, "w")
    else:
        f = sys.stdout
    try:
        yield f
    finally:
        if f is not sys.stdout:
            f.close()


def to_number(s: str) -> int | float | str:
    try:
        return int(s)
    except ValueError:
        pass
    try:
        return float(s)
    except ValueError:
        pass
    return s


def run_external_command(cmdline):
    try:
        result = subprocess.run(cmdline, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(
            "External command failed with return code: ", e.returncode, file=sys.stderr
        )
        print("External command: ", cmdline, file=sys.stderr)
        print("Command error output: ", file=sys.stderr)
        print(e.stderr, file=sys.stderr)
        raise e


def fpss_fpu_fmadd_issues(text_trace: str):
    cmdline = [FPSS_FPU_FMADD_ISSUES_EXE, text_trace]
    stdout = run_external_command(cmdline)
    return json.loads(stdout)


def main(args):
    parser = argparse.ArgumentParser(
        description="Process a Snitch Verilator trace (both text and JSON), "
        "add extra counters and write the resulting JSON to stdout.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("text_trace", help="Path to the text trace file")
    parser.add_argument("json_trace", help="Path to the JSON trace file")
    parser.add_argument(
        "-x",
        "--no-extra-counters",
        action="store_true",
        help="Skip addition of extra counters to the resulting output section",
    )
    parser.add_argument(
        "-s",
        "--section",
        type=int,
        default=DEFAULT_SECTION,
        help="Extract a specific profile section given its 0-based positional index, "
        "where profile sections are defined by instructions reading the mcycle CSR in the execution trace",
    )
    parser.add_argument(
        "-a",
        "--add",
        nargs=2,
        action="append",
        metavar=("key", "value"),
        help="Additional key-value pairs to be added to the resulting JSON",
    )
    parser.add_argument(
        "-o",
        "--out",
        default="-",
        help="Path to the output file; defaults to stdout",
    )
    args = parser.parse_args()
    # Load JSON profile section of interest
    with open(args.json_trace, "r") as f:
        json_data = json.load(f)
    n_sections = len(json_data)
    if n_sections != EXPECTED_N_SECTIONS:
        raise RuntimeError(
            f"Expected {EXPECTED_N_SECTIONS} profiling sections in the profile "
            "JSON but {n_sections} found, please check that you are extracting "
            "the section relative to the kernel from: {args.json_trace}"
        )
    result = json_data[args.section]
    # Add custom key-value pairs
    if args.add:
        result.update({k: to_number(v) for k, v in args.add})
    # Add extra performance counters
    if not args.no_extra_counters:
        extra = fpss_fpu_fmadd_issues(args.text_trace)
        result.update(extra[args.section])
    # Patch missing counters
    result.setdefault("snitch_stores", 0)
    result.setdefault("fpss_stores", 0)
    # Output
    with open_output_stream(args.out) as out:
        json.dump(result, out, indent=4)


if __name__ == "__main__":
    main()
