#!/usr/bin/env python3

import numpy as np
import argparse

MEMREF_GLOBAL = """
memref.global @{name} : memref<{shape}x{type}> = dense<[
{initializer}
]>
"""


def to_memref_shape(array):
    return "x".join(str(dim) for dim in array.shape)


def to_memref_initializer(array):
    return ",\n".join(f"  {np.array2string(row, separator=', ')}" for row in array)


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
    np.set_printoptions(linewidth=150, formatter={"float": lambda x: f"{x:>6}"})
    print(
        MEMREF_GLOBAL.format(
            name="A",
            type="f32",
            shape=to_memref_shape(A),
            initializer=to_memref_initializer(A),
        )
    )

    print(
        MEMREF_GLOBAL.format(
            name="B",
            type="f32",
            shape=to_memref_shape(B),
            initializer=to_memref_initializer(B),
        )
    )
    print(
        MEMREF_GLOBAL.format(
            name="A_PLUS_B",
            type="f32",
            shape=to_memref_shape(ADD),
            initializer=to_memref_initializer(ADD),
        )
    )
