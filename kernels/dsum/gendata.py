#!/usr/bin/env python3

# usage: `python -m dsum.gendata -p dsum/4x4xf64/params.json`

import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array


def matrix_data(
    M: int, N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array]:
    yield Define("M", M)
    yield Define("N", N)

    t = {64: np.float64, 32: np.float32}[precision]

    m = M
    n = N
    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, (m, n)).astype(t)
    y = np.random.uniform(rmin, rmax, (m, n)).astype(t)
    g = x + y

    yield Array("X", ("M", "N"), x)
    yield Array("Y", ("M", "N"), y)
    yield Array("G", ("M", "N"), g)


if __name__ == "__main__":
    main(matrix_data)
