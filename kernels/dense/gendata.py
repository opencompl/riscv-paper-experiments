#!/usr/bin/env python3

import numpy as np
import argparse
import sys


C_TYPES = {
    "32": "float",
    "64": "double",
}

NUMPY_TYPES = {
    "32": np.single,
    "64": np.double,
}

MLIR_TYPES = {
    "32": "f32",
    "64": "f64",
}

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


def array_to_memref(array: np.array, precision: int, shape=None, symbol=None):
    return MEMREF_GLOBAL.format(
        symbol=symbol or "array",
        type=MLIR_TYPES[str(precision)],
        shape=shape or "x".join(str(dim) for dim in array.shape),
        initializer=array_to_memref_initializer(array),
    )


def array_to_c_initializer(array: np.array):
    return np.array2string(array.flatten(), separator=",\n").strip(" []")


def array_to_c(array: np.array, *, precision: int, shape=None, symbol=None):
    return ARRAY_GLOBAL.format(
        symbol=symbol or "array",
        type=C_TYPES[str(precision)],
        shape=shape or "*".join(str(dim) for dim in array.shape),
        initializer=array_to_c_initializer(array),
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="gendata.py",
        description="Generate literal initializers for a fictional BLAS matmul "
        "(matrix-matrix single precision multiplication) on 2d memrefs",
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
    parser.add_argument("-m", "--rows", type=int, default=8, help="number of rows")
    parser.add_argument(
        "-n", "--columns", type=int, default=8, help="number of columns"
    )
    parser.add_argument(
        "-k",
        "--inner-dimension",
        type=int,
        default=8,
        help="size of inner dimension",
    )
    parser.add_argument(
        "--format", default="c", choices=["mlir", "c"], help="output format"
    )
    parser.add_argument(
        "--precision",
        type=int,
        default=64,
        choices=[32, 64],
        help="floating-point precision to use",
    )
    args = parser.parse_args()

    rmin, rmax = args.range
    m = args.rows
    n = args.columns
    k = args.inner_dimension
    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, m * k).astype(np.float64).reshape((m, k))
    w = np.random.uniform(rmin, rmax, k * n).astype(np.float64).reshape((k, n))
    b = np.random.uniform(rmin, rmax, m * n).astype(np.float64).reshape((m, n))
    y_in = np.random.uniform(rmin, rmax, (m, n)).astype(np.float64)

    y_out = np.fmax(0.0, x @ w + b + y_in)

    printopts = {"linewidth": None, "threshold": sys.maxsize}
    if args.format == "c":
        fmt = array_to_c
        print(f"#define M {m}")
        print(f"#define K {k}")
        print(f"#define N {n}")
        printopts["formatter"] = {"double ": lambda x: f"{x:+}f"}
    else:
        assert args.format == "mlir"
        fmt = array_to_memref
        printopts["sign"] = "+"
    np.set_printoptions(**printopts)
    print(fmt(x, shape="M * K", precision=args.precision, symbol="X"))
    print(fmt(w, shape="K * N", precision=args.precision, symbol="W"))
    print(fmt(b, shape="M * N", precision=args.precision, symbol="B"))
    print(fmt(y_in, shape="M * N", precision=args.precision, symbol="Y_IN"))
    print(fmt(y_out, shape="M * N", precision=args.precision, symbol="Y_OUT"))
