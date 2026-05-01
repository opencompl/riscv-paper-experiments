"""Chebyshev degree table for exp on fixed intervals [a, 0]."""

import math
import matplotlib.pyplot as plt


def chebyshev_degree(E, a, b):
    """Smallest n such that the Lobatto Chebyshev bound for exp on [a,b] is <= E."""
    width = b - a
    n = 0
    bound = math.exp(b) * width / 1.0
    while bound > E:
        n += 1
        bound *= width / (4 * (n + 1))
    return n, bound


def main():
    intervals = [(-10.0, 0.0), (-5.0, 0.0), (-1.0, 0.0)]
    tolerances = [1e-3, 1e-6, 1e-9]

    results = {}
    for a, b in intervals:
        results[(a, b)] = []
        for E in tolerances:
            n, bound = chebyshev_degree(E, a, b)
            results[(a, b)].append((n, bound))

    fig, ax = plt.subplots(figsize=(8.5, 4.2))
    ax.axis("off")

    interval_lines = ["Intervals $[a, b]$ (with $b = 0$):"]
    for a, b in intervals:
        interval_lines.append(
            f"    $a = {a:.1f}$,  $b = {b:.1f}$,  width $= {b - a:.1f}$"
        )
    header = "\n".join(interval_lines)

    fig.suptitle(
        "Chebyshev (Lobatto) degree $n$ for $\\exp$ on $[a, b]$",
        fontsize=13,
        y=0.98,
    )
    fig.text(
        0.05, 0.80, header,
        fontsize=10, family="monospace", va="top", ha="left",
    )

    col_labels = ["Interval", "$E = 10^{-3}$", "$E = 10^{-6}$", "$E = 10^{-9}$"]
    cell_text = []
    for a, b in intervals:
        row = [f"[{a:.0f}, {b:.0f}]"]
        for n, bound in results[(a, b)]:
            row.append(f"n = {n}\n(bound = {bound:.2e})")
        cell_text.append(row)

    table = ax.table(
        cellText=cell_text,
        colLabels=col_labels,
        cellLoc="center",
        loc="center",
        bbox=[0.05, 0.05, 0.9, 0.55],
    )
    table.auto_set_font_size(False)
    table.set_fontsize(10)
    table.scale(1, 1.6)

    for (row, col), cell in table.get_celld().items():
        if row == 0:
            cell.set_text_props(weight="bold")
            cell.set_facecolor("#e0e0e0")
        elif col == 0:
            cell.set_text_props(weight="bold")
            cell.set_facecolor("#f5f5f5")

    out_pdf = "/Users/miazerdick/Developer/riscv-paper-experiments/plots-mia-thesis/output/chebyshev_degree_table.pdf"
    out_png = "/Users/miazerdick/Developer/riscv-paper-experiments/plots-mia-thesis/output/chebyshev_degree_table.png"
    plt.savefig(out_pdf, bbox_inches="tight")
    plt.savefig(out_png, bbox_inches="tight", dpi=200)
    print(f"Saved: {out_pdf}")
    print(f"Saved: {out_png}")

    print("\nDegrees:")
    print(f"  {'interval':<12} {'E=1e-3':<22} {'E=1e-6':<22} {'E=1e-9':<22}")
    for a, b in intervals:
        cells = [f"n={n} ({bound:.2e})" for n, bound in results[(a, b)]]
        label = f"[{a:.0f}, {b:.0f}]"
        print(f"  {label:<12} {cells[0]:<22} {cells[1]:<22} {cells[2]:<22}")


if __name__ == "__main__":
    main()
