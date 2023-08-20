#!/usr/bin/env python3

import numpy as np
import argparse

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
        shape="M * N",
        initializer=array_to_c_initializer(array),
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="gendata.py",
        description="Generate literal initializer for a 2d memref",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("-M", "--rows", type=int, default=16, help="number of rows")
    parser.add_argument(
        "-N", "--columns", type=int, default=16, help="number of columns"
    )
    parser.add_argument(
        "--format", default="mlir", choices=["mlir", "c"], help="output format"
    )
    args = parser.parse_args()
    A = (
        np.arange(0, args.rows * args.columns, dtype=np.float32).reshape(
            args.rows, args.columns
        )
        / 10.0
    )
    B = A / 2.0
    ADD = A + B
    if args.format == "c":
        formatter = array_to_c
        np.set_printoptions(linewidth=None, formatter={"float": lambda x: f"{x:.10f}f"})
        # Bounds macros:
        print(f"#define M {args.rows}")
        print(f"#define N {args.columns}")
    else:
        assert args.format == "mlir"
        formatter = array_to_memref
        np.set_printoptions(linewidth=None, formatter={"float": lambda x: f"{x:>6}"})
    print(formatter(A, symbol="A"))
    print(formatter(B, symbol="B"))
    print(formatter(ADD, symbol="A_PLUS_B"))
