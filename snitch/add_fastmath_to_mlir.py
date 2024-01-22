#!/usr/bin/env python3

import re
import sys
import argparse

PARSER = argparse.ArgumentParser(
    description="""
Add fastmath<fast> attribute to the custom format of the following arith operations:
    - arith.addf
    - arith.mulf
    - arith.divf
    - arith.maximumf
The intention is to use this is linalg.generic.
Reads from standard input and writes to standard output.
""",
    formatter_class=argparse.RawDescriptionHelpFormatter,
)


if __name__ == "__main__":
    args = PARSER.parse_args()

    ir = sys.stdin.read()

    # define the regular expression patterns
    patterns = [
        r'(\s%\d+ = arith\.addf %\w+, %\w+)(\s: f64)',
        r'(\s%\d+ = arith\.mulf %\w+, %\w+)(\s: f64)',
        r'(\s%\d+ = arith\.divf %\w+, %\w+)(\s: f64)',
        r'(\s%\d+ = arith\.maximumf %\w+, %\w+)(\s: f64)',
    ]

    # define the replacement string
    replacement = r'\1 fastmath<fast>\2'

    # perform the substitution
    for pattern in patterns:
        ir = re.sub(pattern, replacement, ir)

    print(ir)
