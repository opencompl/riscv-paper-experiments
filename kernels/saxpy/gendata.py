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
        shape="N",
        initializer=array_to_c_initializer(array),
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="gendata.py",
        description="Generate literal initializers for a BLAS saxpy on 1d memrefs",
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
    parser.add_argument("-n", "--length", type=int, default=64, help="vector length")
    parser.add_argument(
        "--format", default="c", choices=["mlir", "c"], help="output format"
    )
    args = parser.parse_args()

    rmin, rmax = args.range
    length = args.length
    np.random.seed(0)
    a = np.random.uniform(rmin, rmax, 1).astype(np.float32)[0]
    x = np.random.uniform(rmin, rmax, length).astype(np.float32)
    y = np.random.uniform(rmin, rmax, length).astype(np.float32)

    g = a * x + y

    printopts = {"linewidth": None, "threshold": sys.maxsize}
    if args.format == "c":
        fmt = array_to_c
        print(f"#define N {length}")
        print(f"#define A {a}f")
        printopts["formatter"] = {"float": lambda x: f"{x:+}f"}
    else:
        assert args.format == "mlir"
        fmt = array_to_memref
        print(f"arith.constant {a} : f32")
        printopts["sign"] = "+"
    np.set_printoptions(**printopts)
    print(fmt(x, symbol="X"))
    print(fmt(y, symbol="Y"))
    print(fmt(g, symbol="G"))
