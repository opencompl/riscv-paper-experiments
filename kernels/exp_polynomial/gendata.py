#!/usr/bin/env python3

import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array


# Chebyshev approximation domain for the exp kernel. Must match the
# `domain_lower`/`domain_upper` attributes injected into polynomial.eval
# by the Snakefile rule for the `linalg_xdsl_d*` variants.
DOMAIN_LOWER: float = -2.0
DOMAIN_UPPER: float = 0.0


def exp_polynomial_data(
    N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array]:
    yield Define("N", N)

    t = {16: np.float16, 32: np.float32, 64: np.float64}[precision]

    # Clamp the random range to the approximation domain so inputs stay
    # inside [DOMAIN_LOWER, DOMAIN_UPPER] where the Chebyshev fit is valid.
    rmin = max(rmin, DOMAIN_LOWER)
    rmax = min(rmax, DOMAIN_UPPER)

    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, N).astype(t)

    # Compute golden reference in float64 then cast down.
    g = np.exp(x.astype(np.float64)).astype(t)

    yield Array("X", ("N",), x)
    yield Array("G", ("N",), g)


if __name__ == "__main__":
    main(exp_polynomial_data)
