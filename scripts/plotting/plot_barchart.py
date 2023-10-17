#!/usr/bin/env python3

"""
Barchart plotting script.
"""

import os
import sys
import json
import argparse

from typing import List, NoReturn, Tuple
from matplotlib.backends.backend_pdf import PdfPages
from matplotlib.ticker import ScalarFormatter, NullLocator

import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt


ColorType = Tuple[float, float, float, float]


def fill_color(color: List[ColorType], num_expected_colors: int) -> List[ColorType]:
    """Fills in the missing number of colours with grays."""

    if len(color) < num_expected_colors:
        sys.stderr.write("Warning: Using defaults to fill in for missing colors.\n")

        cmap = mpl.colormaps["Greys"]
        step = 1.0 / num_expected_colors
        for i in range(0, num_expected_colors):
            if i not in color:
                color.append(cmap((i + 1) * step))

    return color


def plot(
    datafile: str,
    stylefile: str,
    configfile: str,
    interactive: bool = False,
    sort: bool = False,
) -> None:
    """Plots a (grouped) barchart."""

    plt.style.use(stylefile)

    cfg = json.loads("{}")

    with open(configfile, encoding="utf-8") as jsonfile:
        cfg = json.load(jsonfile)

    cfg_df = cfg.setdefault("df", {})

    filename, _ = os.path.splitext(datafile)
    dframe = pd.read_csv(datafile, **cfg_df)

    if sort:
        dframe.sort_index(inplace=True, key=lambda col: col.str.swapcase())

    group_cfg = cfg.get("group", None)

    if group_cfg and (groupby := group_cfg.get("by", None)):
        group_headers = group_cfg.get("group_headers", None)
        filt = group_cfg.get("filter", None)

        if not group_headers:
            raise RuntimeError("missing \"group_headers\" field from configuration")

        if not filt:
            raise RuntimeError("missing \"filter\" field from configuration")

        columns = dframe[group_headers]
        dframe = dframe.groupby(groupby).apply(lambda x: x)
        dframe = dframe.drop(columns=groupby)
        dframe = dframe.unstack(fill_value=0)
        dframe = dframe[filt]
        dframe.rename(columns=columns, inplace=True)

        unique_columns = sorted(set(columns))
        dframe2 = pd.DataFrame(data=None, columns=unique_columns, index=dframe.index)

        for ucol in unique_columns:
            summed = dframe[[ucol]].sum(axis=1)
            dframe2[ucol] = summed

        dframe = dframe2

    _, axis = plt.subplots()

    cfg_plot = cfg.setdefault("plot", {})

    color = cfg_plot.get("color", [])
    fill_color(color, len(dframe.columns))
    cfg_plot["color"] = color

    cfg_plot["figsize"] = tuple(cfg_plot.setdefault("figsize", (8, 5)))

    plot_kind = cfg_plot.setdefault("kind", "bar")
    cfg_plot_kind = cfg.setdefault(plot_kind, {})

    dframe_all = []

    dframe_all.append(dframe)

    for _, dfpart in enumerate(dframe_all):
        dfpart.plot(
            ax=axis,
            legend=False,
            **cfg_plot,
            **cfg_plot_kind,
        )

    cfg_axis = cfg["axis"]

    xticks_cfg = cfg_axis.get("xticks", {})
    plt.xticks(**xticks_cfg)

    axis.set_yscale(cfg_axis["yscale"])
    axis.set_ylim(cfg_axis["ylim"])
    plt.yticks(ticks=cfg_axis["yticks"]["values"])

    axis.yaxis.set_major_formatter(ScalarFormatter())
    axis.yaxis.set_minor_locator(NullLocator())

    axis.set_xlabel(cfg_axis["xlabel"])
    axis.set_ylabel(cfg_axis["ylabel"])

    axis.grid(axis=cfg["axis"]["grid"])

    nstacks = len(dframe_all[0].columns)

    xticks = axis.xaxis.get_major_locator().locs

    if cfg_legend := cfg.get("legend", None):
        frame_linewidth = cfg_legend.get("frame_linewidth", 0.5)
        del cfg_legend["frame_linewidth"]

        handle, labels1 = axis.get_legend_handles_labels()
        legend1 = axis.legend(handle[:nstacks], labels1[:nstacks], **cfg_legend)
        legend1.get_frame().set_linewidth(frame_linewidth)

    if expand_by := cfg_axis.get("xticks_expand_by", 0):
        xticks_cfg["ticks"] = [xticks[0] - expand_by, *xticks, xticks[-1] + expand_by]
        plt.xticks(**xticks_cfg)

    if interactive:
        plt.show()
    else:
        pdf_file = PdfPages(filename + ".pdf")
        plt.savefig(pdf_file, format="pdf")
        pdf_file.close()


def is_valid_file(arg_parser: argparse.ArgumentParser, arg: str) -> str | NoReturn:
    """Checks if the given string is an existing file."""

    if not os.path.exists(arg):
        arg_parser.error(f"Path \"{arg}\" does not exist.")
    elif not os.path.isfile(arg):
        arg_parser.error(f"Path \"{arg}\" is not a file.")

    return arg


#


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate bar chart.")
    parser.add_argument(
        "-f",
        "--file-input",
        type=lambda x: is_valid_file(parser, x),
        required=True,
        metavar="FILE",
        help="Input data file in CSV format",
    )
    parser.add_argument(
        "-s",
        "--style",
        type=lambda x: is_valid_file(parser, x),
        required=True,
        metavar="FILE",
        help="Style sheet configuration file for plotting parameters",
    )
    parser.add_argument(
        "-c",
        "--config",
        type=lambda x: is_valid_file(parser, x),
        required=True,
        metavar="FILE",
        help="Supplementary configuration file for plotting parameters",
    )
    parser.add_argument(
        "-i",
        "--interactive",
        action="store_true",
        help="Display interactive plot only",
    )
    parser.add_argument(
        "--sort",
        action="store_true",
        help="Display interactive plot only",
    )
    args = parser.parse_args()

    plot(args.file_input, args.style, args.config, args.interactive, args.sort)
