#!/usr/bin/env python3

# usage: `python -m dsum.gendata -p dsum/4x4xf64/params.json`

import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array, Scalar


def sum_pool_data(
    M: int, N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array | Scalar]:
    n = 1  # n for number of elements in a batch
    c = 1  # c for channels

    # Define the pooling parameters
    pool_size = (3, 3)
    stride = 1

    new_h = M
    new_w = N

    H = (new_h - 1) * stride + pool_size[0] + 1
    W = (new_w - 1) * stride + pool_size[1] + 1

    np.random.seed(0)
    t = {64: np.float64, 32: np.float32}[precision]
    x = np.random.uniform(rmin, rmax, (n, c, H, W)).astype(t)

    # Perform the max pooling operation
    y_in = np.random.uniform(rmin, rmax, (n, c, new_h, new_w)).astype(t)
    y_out = y_in.copy()

    for row in range(new_h):
        for col in range(new_w):
            pooling_region = x[
                :,
                :,
                row * stride : row * stride + pool_size[0],
                col * stride : col * stride + pool_size[1],
            ]
            y_out[:, :, row, col] = np.sum(pooling_region, axis=(2, 3))

    yield Define("N", n)
    yield Define("C", c)
    yield Define("H", H)
    yield Define("W", W)
    yield Define("NEW_H", new_h)
    yield Define("NEW_W", new_w)

    yield Array("X", ("N", "C", "H", "W"), x)
    yield Array("Y_IN", ("NEW_H", "NEW_W"), y_in)
    yield Array("Y_OUT", ("NEW_H", "NEW_W"), y_out)


if __name__ == "__main__":
    main(sum_pool_data)
