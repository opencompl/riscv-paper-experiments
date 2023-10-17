#!/usr/bin/env python3

from typing import List, Iterator
from itertools import chain

import os
import csv
import json
import argparse

import glob
from pathlib import Path

DEFAULT_ROOT_DIR = "kernels"
DEFAULT_LOG_DIR_SUFFIX = ".x.logs"
DEFAULT_LOG_DIR_DEPTH = 3
DEFAULT_JSON_LOGFILE = "trace_hart_00000000.trace.json"
DEFAULT_JSON_LOGFILE_LIST_NUMBER = 3


def parse_log_file(filename: str, extract_names: List[str]) -> Iterator[str]:
    """Parse JSON log files from Verilator tracing."""
    with open(filename, encoding="UTF-8") as fh:
        trace = json.load(fh)
        if len(trace) != DEFAULT_JSON_LOGFILE_LIST_NUMBER:
            raise RuntimeError(
                f"Log JSON structure expects a list of {DEFAULT_JSON_LOGFILE_LIST_NUMBER} objects."
            )

        for name in extract_names:
            yield trace[1][name]


#

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Harver JSON logs.")
    parser.add_argument(
        "-s",
        "--root-dir",
        type=Path,
        metavar="DIR",
        default=Path(__file__).absolute().parent / DEFAULT_ROOT_DIR,
        help="Top-level directory to search for kernel run logs",
    )
    parser.add_argument(
        "-f",
        "--fieldnames",
        type=str,
        metavar="STRING",
        required=True,
        nargs="*",
        help="Field names to use as CSV header row",
    )
    parser.add_argument(
        "-e",
        "--extract-names",
        type=str,
        metavar="STRING",
        required=True,
        nargs="*",
        help="JSON names/fields to extract from log files",
    )
    parser.add_argument(
        "-o",
        "--output-file",
        type=Path,
        metavar="FILE",
        default="output.csv",
        help="Output data file in CSV or JSON format",
    )
    args = parser.parse_args()

    pattern = f'{args.root_dir}/**/*{DEFAULT_LOG_DIR_SUFFIX}'
    logdirs = glob.glob(pattern, root_dir=args.root_dir, recursive=True)

    logdirs = [f for f in logdirs if os.path.isdir(f)]

    expected_data_fields = DEFAULT_LOG_DIR_DEPTH + len(args.extract_names)
    if expected_data_fields != len(args.fieldnames):
        raise RuntimeError(
            f"Given {len(args.fieldnames)} field names is not equal to the expected {expected_data_fields} data fields"
        )

    prefix_to_remove = len(Path(args.root_dir).parts)

    suffix = Path(args.output_file).suffix

    if suffix not in ['.csv', '.json']:
        raise RuntimeError(f"Provided output suffix \"{suffix}\" is not supported.")

    use_csv = suffix == '.csv'

    data = []

    for f in logdirs:
        log_file = os.path.join(f, DEFAULT_JSON_LOGFILE)
        if not os.path.isfile(log_file):
            continue

        parts = list(Path(f).parts[prefix_to_remove:])
        if len(parts) != DEFAULT_LOG_DIR_DEPTH:
            raise RuntimeError(f"Log directory depth is not {DEFAULT_LOG_DIR_DEPTH}.")

        parts[2] = Path(parts[2]).stem

        data.append(list(chain(parts, parse_log_file(log_file, args.extract_names))))

    with open(args.output_file, 'w', encoding="UTF-8") as fh:
        if use_csv:
            writer = csv.writer(fh)

            writer.writerow(args.fieldnames)

            for row in data:
                writer.writerow(row)
        else:
            jdata = []

            for row in data:
                jdata.append(dict(zip(args.fieldnames, row)))

            json_str = json.dumps(jdata, indent=4)
            fh.write(json_str)
