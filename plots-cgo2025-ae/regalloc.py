import re
import pandas as pd
from data import get_regalloc as _get_regalloc


def get_regalloc() -> pd.DataFrame:
    regalloc_df = _get_regalloc()

    return regalloc_df


def color(color: str, text: str) -> str:
    return r"\textcolor{" + color + "}{" + text + "}"


def print_regalloc(regalloc_df: pd.DataFrame, *, filename: str | None = None):
    stream = None if filename is None else open(filename, "w")
    colors = (color("lightgray", "/20"), color("lightgray", "/15"))

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

        reg_cells = tuple(f"{reg}{col}" for reg, col in zip(regs, colors))

        string_table.append([str(p) for p in params + reg_cells])

    current_precision = None

    for row in string_table:
        line = ""

        # replace NxM where N and M are integers with N$\times$M in kernel names
        pattern = r"(\d+)x(\d+)"
        row[0] = re.sub(pattern, r"\1$\\times$\2", row[0])

        # add short row space to separate precision groups
        if current_precision is None:
            current_precision = row[1]

        if current_precision != row[1]:
            current_precision = row[1]
            line = "\\addlinespace[0.5em]\n"

        line += " & ".join(val for val in row)
        print(line, end=" \\\\\n", file=stream)

    print(r"\bottomrule", file=stream)
    if stream is not None:
        stream.close()
