#!/usr/bin/env python3

import sys
import argparse
import re

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="make_memref.py",
        description="Generate source for matrix multiplication on 2d memrefs as C_{m x n} = A_{m x k} B_{k x n}",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("-m", type=int, default=8, help="m")
    parser.add_argument("-n", type=int, default=8, help="n")
    parser.add_argument("-k", type=int, default=8, help="k")
    args = parser.parse_args()
    M = re.compile("{M}")
    N = re.compile("{N}")
    K = re.compile("{K}")
    src = sys.stdin.read()
    src = re.sub(M, f"{args.m}", src)
    src = re.sub(N, f"{args.n}", src)
    src = re.sub(K, f"{args.k}", src)
    print(src)
