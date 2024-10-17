#!/usr/bin/env python3

# usage: `python -m matmul.gendata -p matmul/4x4xf64/params.json`

import numpy as np
from collections.abc import Iterator

from gendatautils import main, Define, Array


def matrix_data(
    M: int, K: int, N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array]:
    yield Define("M", M)
    yield Define("K", K)
    yield Define("N", N)

    t = {32: np.float32, 64: np.float64}[precision]

    # Errors accumulate a lot with the strategy used in snrt,
    # especially due to the repeated (quite a bit) flaky SIMD reductions.
    # If we want to keep the same absolute tolerance for correctness checks,
    # we need to clamp our random distribution range to +-10^2:
    rmin = max(rmin, -100.0)
    rmax = min(rmax, 100.0)

    m = M
    n = N
    k = K
    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, (m, k)).astype(t)
    y = np.random.uniform(rmin, rmax, (k, n)).astype(t)
    g_in = np.zeros((m, n), dtype=t)

    g_out = x @ y

    yield Array("X", ("M", "K"), x)
    yield Array("Y", ("N", "K"), y.transpose())  # beware: B is laid out transposed
    yield Array("G_IN", ("M", "N"), g_in)
    yield Array("G_OUT", ("M", "N"), g_out)


if __name__ == "__main__":
    main(matrix_data)
