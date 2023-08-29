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
        type="i32",  # FIXME handle properly
        shape="x".join(str(dim) for dim in array.shape),
        initializer=array_to_memref_initializer(array),
    )


def array_to_c_initializer(array: np.array):
    return np.array2string(array.flatten(), separator=",\n").strip(" []")


def array_to_c(array: np.array, *, symbol=None):
    return ARRAY_GLOBAL.format(
        symbol=symbol or "array",
        type="int32_t",  # FIXME handle properly
        # shape="*".join(str(dim) for dim in array.shape),
        shape="N",
        initializer=array_to_c_initializer(array),
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="gendata.py",
        description="Generate literal initializers for a HWPE simple_mult on 1d memrefs",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-r",
        "--range",
        type=int,
        nargs=2,
        default=(-1000, 1000),
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
    A = np.random.uniform(rmin, rmax, length).astype(np.int32)
    B = np.random.uniform(rmin, rmax, length).astype(np.int32)

    G = A * B 

    printopts = {"linewidth": None, "threshold": sys.maxsize}
    if args.format == "c":
        fmt = array_to_c
        print(f"#define N {length}")
        printopts["formatter"] = {"int32_t": lambda x: f"{x:+}"}
    else:
        assert args.format == "mlir"
        fmt = array_to_memref
        printopts["sign"] = "+"
    np.set_printoptions(**printopts)
    print(fmt(A, symbol="A"))
    print(fmt(B, symbol="B"))
    print(fmt(G, symbol="G"))
