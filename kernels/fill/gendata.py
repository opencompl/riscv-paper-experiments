#!/usr/bin/env python3

# usage: `python -m dsum.gendata -p dsum/4x4xf64/params.json`

import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array, Scalar


def fill_data(
    M: int, N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array | Scalar]:
    yield Define("M", M)
    yield Define("N", N)

    t = {64: np.float64, 32: np.float32}[precision]

    m = M
    n = N
    np.random.seed(0)
    val = 4.0  # chosen by fair dice roll. guaranteed to be random

    y = np.empty((m, n), dtype=t)
    y.fill(val)

    yield Scalar("X", precision, val)
    yield Array("Y", ("M", "N"), y)


if __name__ == "__main__":
    main(fill_data)
