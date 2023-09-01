#!/usr/bin/env python3

import numpy as np
import argparse
import sys

MEMREF_GLOBAL = """
memref.global constant @{symbol} : memref<{shape}x{type}> = dense<[
{initializer}
]>
"""


ARRAY_GLOBAL = """
const {type} {symbol}[{shape}] = {{
{initializer}
}};
"""


def array_to_memref_initializer(array: np.array):
    return ",\n".join(f"  {np.array2string(row, separator=', ')}" for row in array)


def array_to_memref(array: np.array, symbol=None):
    return MEMREF_GLOBAL.format(
        symbol=symbol or "array",
        type="f32",  # FIXME handle properly
        shape="x".join(str(dim) for dim in array.shape),
        initializer=array_to_memref_initializer(array),
    )


def array_to_c_initializer(array: np.array):
    return np.array2string(array.flatten(), separator=",\n").strip(" []")


def array_to_c(array: np.array, *, symbol=None):
    return ARRAY_GLOBAL.format(
        symbol=symbol or "array",
        type="float",  # FIXME handle properly
        # shape="*".join(str(dim) for dim in array.shape),
        shape="N * M",
        initializer=array_to_c_initializer(array),
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="gendata.py",
        description="Generate literal initializers for a fictional BLAS ssum "
        "(elementwise matrix-matrix single precision add) on 2d memrefs",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-r",
        "--range",
        type=float,
        nargs=2,
        default=(-1000.0, 1000.0),
        help="uniform distribution range",
    )
    parser.add_argument("-m", "--rows", type=int, default=16, help="number of rows")
    parser.add_argument(
        "-n", "--columns", type=int, default=16, help="number of columns"
    )
    parser.add_argument(
        "--format", default="c", choices=["mlir", "c"], help="output format"
    )
    args = parser.parse_args()

    rmin, rmax = args.range
    m = args.rows
    n = args.columns
    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, m * n).astype(np.float32).reshape((m, n))
    y = np.random.uniform(rmin, rmax, m * n).astype(np.float32).reshape((m, n))

    g = x + y

    printopts = {"linewidth": None, "threshold": sys.maxsize}
    if args.format == "c":
        fmt = array_to_c
        print(f"#define M {m}")
        print(f"#define N {n}")
        printopts["formatter"] = {"float": lambda x: f"{x:+}f"}
    else:
        assert args.format == "mlir"
        fmt = array_to_memref
        printopts["sign"] = "+"
    np.set_printoptions(**printopts)
    print(fmt(x, symbol="X"))
    print(fmt(y, symbol="Y"))
    print(fmt(g, symbol="G"))
