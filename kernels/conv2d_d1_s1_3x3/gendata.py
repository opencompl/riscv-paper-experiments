#!/usr/bin/env python3

# usage: `python -m dsum.gendata -p dsum/4x4xf64/params.json`

import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array, Scalar


def conv_data(
    H: int, W: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array | Scalar]:
    n = 1  # n for number of elements in a batch
    c = 1  # c for channels
    F = 1  # number of features

    kernel_size = (3, 3)
    stride = 1

    np.random.seed(0)
    t = {64: np.float64, 32: np.float32}[precision]
    x = np.random.uniform(rmin, rmax, (n, c, H, W)).astype(t)
    y = np.random.uniform(rmin, rmax, (F, c, kernel_size[0], kernel_size[1])).astype(t)

    new_h = (H - kernel_size[0]) // stride + 1
    new_w = (W - kernel_size[1]) // stride + 1

    z_in = np.random.uniform(rmin, rmax, (n, F, new_h, new_w)).astype(t)
    z_out = np.zeros((n, F, new_h, new_w)).astype(t)

    for i in range(F):
        for row in range(0, H - kernel_size[0] + 1, stride):
            for col in range(0, W - kernel_size[1] + 1, stride):
                receptive_field = x[
                    :, :, row : row + kernel_size[0], col : col + kernel_size[1]
                ]
                z_out[:, i, row // stride, col // stride] = np.sum(
                    receptive_field * y[i, :, :, :]
                )

    yield Define("N", n)
    yield Define("C", c)
    yield Define("H", H)
    yield Define("W", W)
    yield Define("F", F)
    yield Define("NEW_H", new_h)
    yield Define("NEW_W", new_w)

    yield Array("X", ("N", "C", "H", "W"), x)
    yield Array("Y", ("F", "C", "3", "3"), y)
    yield Array("Z_IN", ("N", "F", "NEW_H", "NEW_W"), z_in)
    yield Array("Z_OUT", ("N", "F", "NEW_H", "NEW_W"), z_out)


if __name__ == "__main__":
    main(conv_data)
