# i need to generate an input data array X somehow here 
import numpy as np
from gendatautils import main, Define, Array
from typing import Iterator

def exp_data(
    N: int, rmin: float, rmax: float, precision: int
) -> Iterator[Define | Array]:
    yield Define("N", N)

    # Clamp range to avoid overflow in exp
    rmin = max(rmin, -10.0)
    rmax = min(rmax, 10.0)

    np.random.seed(0)
    x = np.random.uniform(rmin, rmax, N).astype(np.float64)

    # Compute golden reference in float64 then cast down
    g = np.exp(x.astype(np.float64)).astype(np.float64)

    yield Array("X", ("N",), x)
    yield Array("G", ("N",), g)


if __name__ == "__main__":
    main(exp_data)