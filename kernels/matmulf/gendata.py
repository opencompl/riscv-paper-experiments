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
        description="Generate literal initializer for matrix multiplication on 2d memrefs as C_{m x n} = A_{m x k} B_{k x n}",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("-m", type=int, default=8, help="m")
    parser.add_argument("-n", type=int, default=8, help="n")
    parser.add_argument("-k", type=int, default=8, help="k")
    args = parser.parse_args()
    rng = np.random.default_rng(seed=0)
    A = rng.standard_normal(args.m * args.k, dtype=np.float32).reshape(args.m, args.k)
    B = rng.standard_normal(args.k * args.n, dtype=np.float32).reshape(args.k, args.n)
    C = np.zeros(args.m * args.n, dtype=np.float32).reshape(args.m, args.n)
    np.matmul(A, B, out=C)
    np.set_printoptions(linewidth=None, formatter={"float": lambda x: f"{x:>6}"})
    print(array_to_memref(A, "A"))
    print(array_to_memref(B, "B"))
    print(array_to_memref(C, "C"))
