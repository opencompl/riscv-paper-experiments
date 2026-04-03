#!/usr/bin/env python3

import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array


def exp_data(
    N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array]:
    yield Define("N", N)

    t = {16: np.float16, 32: np.float32, 64: np.float64}[precision]

    # Clamp range to avoid overflow in exp
    rmin = max(rmin, -30.0)
    rmax = min(rmax, 0.0)

    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, N).astype(t)

    # Compute golden reference in float64 then cast down
    g = np.exp(x.astype(np.float64)).astype(t)

    yield Array("X", ("N",), x)
    yield Array("G", ("N",), g)


if __name__ == "__main__":
    main(exp_data)
