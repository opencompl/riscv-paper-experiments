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
    n = 1  # n for number of elements in a batch
    c = 1  # c for channels
    h = args.rows  # h for height
    w = args.columns  # w for width
    f = 1  # number of features

    kernel_size = (3, 3)
    stride = 1

    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, (n, c, h, w))
    y = np.random.uniform(rmin, rmax, (f, c, kernel_size[0], kernel_size[1]))

    new_h = (h - kernel_size[0]) // stride + 1
    new_w = (w - kernel_size[1]) // stride + 1

    # Perform the max pooling operation
    z_in = np.random.uniform(rmin, rmax, (n, f, new_h, new_w))
    z_out = np.zeros((n, f, new_h, new_w))

    for i in range(f):
        for row in range(0, h - kernel_size[0] + 1, stride):
            for col in range(0, w - kernel_size[1] + 1, stride):
                receptive_field = x[
                    :, :, row : row + kernel_size[0], col : col + kernel_size[1]
                ]
                z_old = z_in[:, i, row // stride, col // stride]
                z = z_old + np.sum(receptive_field * y[i, :, :, :])
                z_out[:, i, row // stride, col // stride] = z

    printopts = {"linewidth": None, "threshold": sys.maxsize}
    if args.format == "c":
        fmt = array_to_c
        print(f"#define N {n}")
        print(f"#define C {c}")
        print(f"#define H {h}")
        print(f"#define W {w}")
        print(f"#define F {f}")
        print(f"#define NEW_H {new_h}")
        print(f"#define NEW_W {new_w}")
        printopts["formatter"] = {"double ": lambda x: f"{x:+}f"}
    else:
        assert args.format == "mlir"
        fmt = array_to_memref
        printopts["sign"] = "+"
    np.set_printoptions(**printopts)
    print(fmt(x, shape="N * C * H * W", precision=args.precision, symbol="X"))
    print(fmt(y, shape="F * C * 3 * 3", precision=args.precision, symbol="Y"))
    print(
        fmt(
            z_in, shape="N * F * NEW_H * NEW_W", precision=args.precision, symbol="Z_IN"
        )
    )
    print(
        fmt(
            z_out,
            shape="N * F * NEW_H * NEW_W",
            precision=args.precision,
            symbol="Z_OUT",
        )
    )
