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
    parser.add_argument("-m", "--rows", type=int, default=16, help="number of rows")
    parser.add_argument(
        "-n", "--columns", type=int, default=16, help="number of columns"
    )
    parser.add_argument(
        "-k",
        "--inner-dimension",
        type=int,
        default=16,
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
    batch_size = 1
    m = args.rows
    n = args.columns
    channels = 1
    np.random.seed(0)
    x = (
        np.random.uniform(rmin, rmax, batch_size * m * n * channels)
        .astype(np.float64)
        .reshape((batch_size, m, n, channels))
    )

    # Define the pooling parameters
    pool_size = (3, 3)
    stride = 2

    # Perform the max pooling operation
    y = np.zeros(
        (
            x.shape[0],
            (x.shape[1] - pool_size[0]) // stride + 1,
            (x.shape[2] - pool_size[1]) // stride + 1,
            x.shape[3],
        )
    )

    for h in range(0, x.shape[1] - pool_size[0] + 1, stride):
        for w in range(0, x.shape[2] - pool_size[1] + 1, stride):
            pooling_region = x[:, h : h + pool_size[0], w : w + pool_size[1], :]
            y[:, h // stride, w // stride, :] = np.max(pooling_region, axis=(1, 2))

    printopts = {"linewidth": None, "threshold": sys.maxsize}
    if args.format == "c":
        fmt = array_to_c
        print(f"#define M {m}")
        print(f"#define N {n}")
        printopts["formatter"] = {"double ": lambda x: f"{x:+}f"}
    else:
        assert args.format == "mlir"
        fmt = array_to_memref
        printopts["sign"] = "+"
    np.set_printoptions(**printopts)
    print(fmt(x, shape="M * N", precision=args.precision, symbol="X"))
    print(fmt(y, shape="N", precision=args.precision, symbol="Y"))
