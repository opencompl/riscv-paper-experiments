#!/usr/bin/env python3

import numpy as np
import argparse

MEMREF_GLOBAL = """
memref.global constant @{symbol} : memref<{shape}x{type}> = dense<[
{initializer}
]>
"""


def array_to_memref_shape(array):
    return "x".join(str(dim) for dim in array.shape)


def array_to_memref_initializer(array):
    return ",\n".join(f"  {np.array2string(row, separator=', ')}" for row in array)


def array_to_memref_dtype(array):
    return "f32"


def array_to_memref(array, symbol=None):
    return MEMREF_GLOBAL.format(
        symbol=symbol or "array",
        type=array_to_memref_dtype(array),
        shape=array_to_memref_shape(array),
        initializer=array_to_memref_initializer(array),
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="make_memref.py",
        description="Generate literal initializer for a 2d memref",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("-c", "--columns", type=int, default=16, help="number of rows")
    parser.add_argument("-r", "--rows", type=int, default=16, help="number of columns")
    args = parser.parse_args()
    print(args)
    A = np.arange(0, args.rows * args.columns, dtype=np.float32).reshape(
        args.rows, args.columns
    )
    B = A / 2.0
    ADD = A + B
    np.set_printoptions(linewidth=None, formatter={"float": lambda x: f"{x:>6}"})
    print(array_to_memref(A, "A"))
    print(array_to_memref(B, "B"))
    print(array_to_memref(ADD, "A_PLUS_B"))
