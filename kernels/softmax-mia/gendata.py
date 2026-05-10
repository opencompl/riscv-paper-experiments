#!/usr/bin/env python3

import numpy as np
from typing import Iterator

from gendatautils import main, Define, Array


def softmax_data(
    N: int, acc_exp: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array]:
    yield Define("N", N)
    yield Define("ACC_EXP", acc_exp)

    t = {16: np.float16, 32: np.float32, 64: np.float64}[precision]

    # Clamp to a range that yields a numerically reasonable softmax
    # (also keeps the polynomial exp approximation in its accurate region).
    rmin = max(rmin, -1.0)
    rmax = min(rmax, 1.0)

    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, N).astype(t)

    x64 = x.astype(np.float64)
    e = np.exp(x64 - np.max(x64))
    g = (e / e.sum()).astype(t)

    yield Array("X", ("N",), x)
    yield Array("G", ("N",), g)


if __name__ == "__main__":
    main(softmax_data)
