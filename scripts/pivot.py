import pandas as pd
import math

df = pd.read_csv("kernels.csv")

df["kernels"] = df["test"].astype(str) + " " + df["params"]

# Filter the DataFrame to keep only the necessary columns
df = df[["kernels", "impl", "cycles", "fpss_fpu_occupancy"]]

PIVOTED_COLS = set(
    ("linalg", "baseline", "snitch_stream", "snrt", "linalg_xdsl", "scf_xdsl")
)

df = df[df["impl"].isin(PIVOTED_COLS)]

pivoted_all = df.pivot(index="kernels", columns="impl")
pivoted = pivoted_all["cycles"]
pivoted_fpu = pivoted_all["fpss_fpu_occupancy"]

pivoted["min_llvm_mlir"] = pivoted[["baseline", "linalg"]].min(axis=1)

# TODO: linalg_xdsl when that's ready
# TODO: uncomment when adding back xdsl flow
# pivoted["speedup"] = pivoted["min_llvm_mlir"].div(pivoted["snitch_stream"]).map(lambda val: f"{val:.2f}x" if not math.isnan(val) else "?x")

# print(bla.dtype)

pivoted.to_csv("pivoted.csv", float_format=lambda val: str(int(val)))
pivoted_fpu.to_csv("pivoted_fpu.csv", float_format=lambda val: f"{val:.2f}")
