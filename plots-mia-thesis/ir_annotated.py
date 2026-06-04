#!/usr/bin/env python3
"""
Annotated IR figure: a concrete `polynomial.eval` op with its four compile-time
aspects (approximation family, coefficients/degree, approximation domain, and
evaluation scheme) highlighted in different colours, keyed to the enumeration
in the polynomial-dialect section of the thesis.

The op is the degree-2 Chebyshev-Lobatto interpolant of exp on [-2, 0] for an
f16 operand. Coefficients are the DCT-I values from
`plot_utils.chebyshev_lobatto_coeffs` (reproduced by `make_ir_snippet()`).

Storage format follows the polynomial dialect merged into xDSL upstream main:
`EvalOp.get` stores the coefficients, the ring's `coefficientType`, AND the
domain bounds in the *operand* element type -- so for an f16 exp everything is
f16 (the values shown are the f16-rounded coefficients). NOTE: the xDSL build
pinned in this repo (and the 170 kernels/*.xdsl.mlir files) predate that change
and still use `coefficientType = f64`; this figure reflects the current
upstream convention the thesis describes.

The header comment shows the thesis-facing `max_bits_lost` attribute on
`math.exp`. For degree 2 on [-2, 0] in f16 the bits-lost bound gives
bits_lost(2) ~ 8.30 and bits_lost(1) ~ 10.89, so max_bits_lost = 9 is the
realistic budget that selects exactly this degree-2 polynomial (8 would bump to
degree 3, 11 would drop to degree 1).

Usage:
    python ir_annotated.py [--output plots-mia-thesis/output/polynomial_eval_ir.pdf]
"""

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

from plot_utils import (
    dark_blue,
    dark_green,
    dark_gray,
    dark_red,
    light_blue,
    light_green,
    light_red,
    savefig,
)

# A fourth hue (orange) completes the four-aspect palette; the rest come from
# the shared ColorBrewer-Paired project palette in plot_utils.
light_orange = "#fdbf6f"
dark_orange = "#ff7f00"

# aspect key -> (fill, edge, legend label)
ASPECTS = {
    "family": (light_blue, dark_blue,
               "approximation family  (Chebyshev basis; extensible)"),
    "coeff":  (light_green, dark_green,
               "coefficients $c_0\\dots c_d$  $\\Rightarrow$  degree $d$  (DCT-I, compile time)"),
    "domain": (light_orange, dark_orange,
               "approximation domain $[lower, upper]$  $\\Rightarrow$  affine map to $[-1, 1]$"),
    "scheme": (light_red, dark_red,
               "evaluation scheme  (Clenshaw recurrence; extensible)"),
}

# Degree-2 Chebyshev-Lobatto coefficients of exp on [-2, 0], stored in the
# operand format f16 (see module docstring). f16-rounded: note 0.4324 != the
# f64 value 0.4323, i.e. the rounding to the coefficient type is visible.
COEFFS = "0.9355, 0.4324, 0.1998"

# The op, on a single line. Each line is a list of (text, aspect-key | None)
# segments; highlighted segments get a coloured box drawn behind them.
CODE_LINES: list[list[tuple[str, str | None]]] = [
    [
        ("%r = ", None),
        ("polynomial.eval ", None),
        ("#polynomial.", None),
        ("typed_chebyshev_polynomial", "family"),
        ("<[", None),
        (COEFFS, "coeff"),
        ("]> : !polynomial.polynomial<ring = <coefficientType = f16>>, ", None),
        ("%x ", None),
        ("{", None),
        ('scheme = "clenshaw"', "scheme"),
        (", ", None),
        ("domain_lower = -2.0 : f16", "domain"),
        (", ", None),
        ("domain_upper = 0.0 : f16", "domain"),
        ("} ", None),
        (": f16", None),
    ],
]

# grey provenance comments shown above / below the op.
# The pass selects the lowest Chebyshev degree meeting the `max_bits_lost`
# budget (the thesis-facing attribute on `math.exp`). On [-2, 0] in f16 the
# bits-lost bound puts degree 2 in the window max_bits_lost in [8.30, 10.89),
# so 9 is the realistic budget that yields the small polynomial shown here.
HEADER = "// math.exp  (f16, max_bits_lost = 9)  --lower-exp-to-polynomial-->"
FOOTER = ("// --expand-polynomial-eval-->  12 branch-free mulf/addf/subf ops"
          "  (no branches, no memory)")

FONT = 11.5
CHAR_IN = 0.6 * FONT / 72.0   # monospace advance width (DejaVu Sans Mono ~0.6em)
LINE_IN = 0.30                 # vertical pitch per text line, inches
LEFT_PAD = 1                  # margin columns
RIGHT_PAD = 2


def make_ir_snippet() -> list[float]:
    """Recompute the degree-2 coefficients on [-2, 0] (the DCT-I the pass uses)
    and round them to f16, the operand/coefficient type the upstream dialect
    stores. Should match COEFFS above."""
    import numpy as np

    from plot_utils import chebyshev_lobatto_coeffs

    return [float(np.float16(c)) for c in chebyshev_lobatto_coeffs(2)]


def _seg_len(line: list[tuple[str, str | None]]) -> int:
    return sum(len(t) for t, _ in line)


def plot_ir() -> plt.Figure:
    # Rows (top to bottom): header, blank, op (one line), blank, footer,
    # blank, legend (one horizontal row).
    code_cols = max(_seg_len(l) for l in CODE_LINES)
    ncols = LEFT_PAD + max(code_cols, len(HEADER), len(FOOTER)) + RIGHT_PAD
    n_rows = 8

    fig_w = ncols * CHAR_IN
    fig_h = n_rows * LINE_IN
    fig = plt.figure(figsize=(fig_w, fig_h))
    ax = fig.add_axes((0, 0, 1, 1))
    ax.set_xlim(0, ncols)
    ax.set_ylim(0, n_rows)
    ax.axis("off")

    def row_y(i: int) -> float:
        return n_rows - 0.5 - i

    # --- provenance header ------------------------------------------------
    ax.text(LEFT_PAD, row_y(0), HEADER, family="monospace", fontsize=FONT - 1.5,
            color=dark_gray, va="center", ha="left", fontstyle="italic")

    # --- the op, with highlighted aspects ---------------------------------
    for li, line in enumerate(CODE_LINES):
        y = row_y(li + 2)
        col = LEFT_PAD
        for text, key in line:
            if key is not None:
                fill, edge, _ = ASPECTS[key]
                ax.add_patch(FancyBboxPatch(
                    (col - 0.15, y - 0.42),
                    len(text) + 0.3, 0.84,
                    boxstyle="round,pad=0.02,rounding_size=0.18",
                    linewidth=1.2, edgecolor=edge, facecolor=fill, zorder=1,
                ))
            weight = "bold" if (text.strip() == "polynomial.eval") else "normal"
            ax.text(col, y, text, family="monospace", fontsize=FONT,
                    va="center", ha="left", zorder=2, fontweight=weight)
            col += len(text)

    # --- footer -----------------------------------------------------------
    ax.text(LEFT_PAD, row_y(4), FOOTER, family="monospace",
            fontsize=FONT - 1.5, color=dark_gray, va="center", ha="left",
            fontstyle="italic")

    # --- legend: 2x2 grid keyed to the op-line width ---------------------
    swatch_w = 2.0
    gap_after_swatch = 0.6
    col_x = [LEFT_PAD, LEFT_PAD + (ncols - LEFT_PAD - RIGHT_PAD) / 2]
    for j, (key, (fill, edge, label)) in enumerate(ASPECTS.items()):
        r, c = divmod(j, 2)
        x = col_x[c]
        y = row_y(6 + r)
        ax.add_patch(FancyBboxPatch(
            (x, y - 0.30), swatch_w, 0.6,
            boxstyle="round,pad=0.02,rounding_size=0.18",
            linewidth=1.2, edgecolor=edge, facecolor=fill, zorder=1,
        ))
        ax.text(x + swatch_w + gap_after_swatch, y, label,
                fontsize=FONT - 1.5, va="center", ha="left", color="#222222")

    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", "-o",
        default="plots-mia-thesis/output/polynomial_eval_ir.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    fig = plot_ir()
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
