#!/usr/bin/env python3

import math as pymath
import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array



DOMAIN_LOWER: float = -1.0
DOMAIN_UPPER: float = 1.0

def polynomial_data(
    N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array]:
    yield Define("N", N)

    t = {16: np.float16, 32: np.float32, 64: np.float64}[precision]

    np.random.seed(0)
    x = np.random.uniform(DOMAIN_LOWER, DOMAIN_UPPER, N).astype(t)

    # Compute golden reference in float64 then cast down
    g = np.exp(x.astype(np.float64)).astype(t)

    yield Array("X", ("N",), x)
    yield Array("G", ("N",), g)


if __name__ == "__main__":
    main(polynomial_data)
