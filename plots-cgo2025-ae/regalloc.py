import pandas as pd
from data import get_regalloc as _get_regalloc

from pathlib import Path


def get_regalloc(dir: Path = Path(".")) -> pd.DataFrame:
    regalloc_df = _get_regalloc(dir)

    return regalloc_df


def print_regalloc(regalloc_df: pd.DataFrame, *, filename: str | None = None):
    stream = None if filename is None else open(filename, "w")

    # Sort the DataFrame
    regalloc_df = regalloc_df.sort_values(
        [
            "Bits",
            "allocated_float",
            "allocated_int",
        ],
        ascending=[False, True, True],
    )

    string_table = []

    for row in regalloc_df.iterrows():
        items = tuple(row[1])
        params = items[:5]
        regs = items[5:]
        max_regs = ("/20", "/15")

        reg_cells = tuple(f"{reg}{max_reg}" for reg, max_reg in zip(regs, max_regs))

        string_table.append([str(p) for p in params + reg_cells])

    current_precision = None

    for row in string_table:
        line = ""

        # add short row space to separate precision groups
        if current_precision is None:
            current_precision = row[1]

        line += ", ".join(val for val in row)
        print(line, file=stream)

    if stream is not None:
        stream.close()
