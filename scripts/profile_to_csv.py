#!/usr/bin/env python3

import sys
import json
import argparse
import contextlib
import pandas as pd


def json_load_file(path):
    with open(path, "r") as f:
        return json.load(f)


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


def main():
    parser = argparse.ArgumentParser(
        description="Merge multiple Snitch section profile JSONs into a single CSV. "
        "Input JSON files specified as positional arguments, write resulting CSV to stdout.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("paths", nargs="*", help="Profile JSON files to collate")
    parser.add_argument(
        "-o",
        "--out",
        default="-",
        help="Path to the output file; defaults to stdout",
    )
    args = parser.parse_args()
    combined = (json_load_file(path) for path in args.paths)
    df = pd.DataFrame(combined)
    columns = sorted(list(df))
    # keep meaningful columns first to make understanding each row easier:
    for col in reversed(["test", "params", "impl"]):
        columns.insert(0, columns.pop(columns.index(col)))
    with open_output_stream(args.out) as out:
        df.to_csv(out, index=False, columns=columns)


if __name__ == "__main__":
    main()
