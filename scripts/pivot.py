import pandas as pd

df = pd.read_csv("kernels.csv", header=None, names=("test", "params", "impl", "cycles"))

df["combined"] = df["test"].astype(str) + " " + df["params"]

pivoted = df.pivot(index="combined", columns="impl")["cycles"]

PIVOTED_COLS = set(("linalg", "baseline", "snitch_stream", "snrt"))

for col in pivoted:
    if col not in PIVOTED_COLS:
        del pivoted[col]

pivoted.to_csv("pivoted.csv", float_format=lambda val: str(int(val)))
