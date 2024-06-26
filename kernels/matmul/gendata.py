#!/usr/bin/env python3

# usage: `python -m matmul.gendata -p matmul/4x4xf64/params.json`

import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array


def matrix_data(
    M: int, K: int, N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array]:
    yield Define("M", M)
    yield Define("K", K)
    yield Define("N", N)

    t = {64: np.float64, 32: np.float32}[precision]

    m = M
    n = N
    k = K
    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, m * k).astype(t).reshape((m, k))
    y = np.random.uniform(rmin, rmax, k * n).astype(t).reshape((k, n))
    g_in = np.random.uniform(rmin, rmax, (m, n)).astype(t)

    g_out = x @ y + g_in

    yield Array("X", ("M", "K"), x)
    yield Array("Y", ("K", "N"), y)
    yield Array("G_IN", ("M", "N"), g_in)
    yield Array("G_OUT", ("M", "N"), g_out)


if __name__ == "__main__":
    main(matrix_data)
