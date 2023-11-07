import pandas as pd

df = pd.read_csv("cycles.csv", header=None, names=("test", "params", "impl", "cycles"))

df["combined"] = df["test"].astype(str) + " " + df["params"]

pivoted = df.pivot(index="combined", columns="impl")["cycles"]

pivoted.to_csv("pivoted.csv", float_format=lambda val: str(int(val)))
