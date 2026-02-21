#!/usr/bin/env python3

import numpy as np
import argparse
import sys

NUMPY_TYPES = {
    "16": np.half,
    "32": np.single,
    "64": np.double,
}

C_TYPES = {
    "16": "__fp16",
    "32": "float",
    "64": "double",
}

ARRAY_GLOBAL = """
const {type} {symbol}[{shape}] = {{
{initializer}
}};
"""


def array_to_c_initializer(array: np.array):
    return np.array2string(array.flatten(), separator=",\n").strip(" []")


def array_to_c(array: np.array, *, symbol=None, ctype="float"):
    return ARRAY_GLOBAL.format(
        symbol=symbol or "array",
        type=ctype,
        shape="N",
        initializer=array_to_c_initializer(array),
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="gendata.py",
        description="Generate literal initializers for an element-wise exp kernel on 1d memrefs",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-r",
        "--range",
        type=float,
        nargs=2,
        default=(-10.0, 10.0),
        help="uniform distribution range",
    )
    parser.add_argument("-n", "--length", type=int, default=64, help="vector length")
    parser.add_argument(
        "-p",
        "--precision",
        type=int,
        default=32,
        choices=[16, 32, 64],
        help="floating point precision in bits",
    )
    args = parser.parse_args()

    rmin, rmax = args.range
    length = args.length
    dtype = NUMPY_TYPES[str(args.precision)]
    ctype = C_TYPES[str(args.precision)]

    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, length).astype(dtype)

    # Compute golden reference in float64 then cast down
    g = np.exp(x.astype(np.float64)).astype(dtype)

    printopts = {"linewidth": None, "threshold": sys.maxsize}
    print(f"#define N {length}")
    printopts["formatter"] = {"all": lambda v: f"{float(v):+}f"}
    np.set_printoptions(**printopts)
    print(array_to_c(x, symbol="X", ctype=ctype))
    print(array_to_c(g, symbol="G", ctype=ctype))
