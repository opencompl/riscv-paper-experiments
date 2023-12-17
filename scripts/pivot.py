import pandas as pd
import math

df = pd.read_csv("kernels.csv", header=None, names=("test", "params", "impl", "cycles"))

df["kernels"] = df["test"].astype(str) + " " + df["params"]

pivoted = df.pivot(index="kernels", columns="impl")["cycles"]

PIVOTED_COLS = set(
    ("linalg", "baseline", "snitch_stream", "snrt", "linalg_xdsl", "scf_xdsl")
)

for col in pivoted:
    if col not in PIVOTED_COLS:
        del pivoted[col]

pivoted["min_llvm_mlir"] = pivoted[["baseline", "linalg"]].min(axis=1)

# TODO: linalg_xdsl when that's ready
pivoted["speedup"] = pivoted["min_llvm_mlir"].div(pivoted["snitch_stream"]).map(lambda val: f"{val:.2f}x" if not math.isnan(val) else "?x")

# print(bla.dtype)

pivoted.to_csv("pivoted.csv", float_format=lambda val: str(int(val)))
