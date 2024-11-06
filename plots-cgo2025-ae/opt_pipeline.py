import pandas as pd

col_names = {
    'Optimizations': '',
    'F Registers': 'FP',
    'X Registers': 'Integer',
    'F Loads': 'Loads',
    'F Stores': 'Stores',
    'FMAdd': 'FMAdd',
    'FRep': 'FRep',
    'Cycles': 'Cycles (\#)',
    'Occupancy': 'Occupancy (\%)',
}

col_alignment = {
    'Optimizations': 'l',
    'F Registers': 'S[table-format=2.0]',
    'X Registers': 'S[table-format=2.0]',
    'F Loads': 'S[table-format=4.0]',
    'F Stores': 'S[table-format=4.0]',
    'FMAdd': 'S[table-format=4.0]',
    'FRep': 'S[table-format=1.0]',
    'Cycles': 'S[table-format=5.0]',
    'Occupancy': 'S[table-format=2.2]',
}


def get_opt_pipeline_table(opt_pipeline_df: pd.DataFrame) -> str:
    # Reorder columns to move Cycles and Occupancy to the end
    cols = opt_pipeline_df.columns.tolist()
    cols = [col for col in cols if col not in ['Cycles', 'Occupancy']] + [
        'Cycles',
        'Occupancy',
    ]
    opt_pipeline_df = opt_pipeline_df[cols]
    del opt_pipeline_df["params"]
    latex_table = "\\begin{table*}[h]\n"

    latex_table += "\\sisetup{group-separator = {\ },group-minimum-digits=3}\n"

    latex_table += (
        "\\setlength\\tabcolsep{0pt} % let LaTeX compute intercolumn whitespace\n"
    )

    latex_table += "\\caption{"
    latex_table += (
        "Our compilation pipeline leverages custom "
        "\\ac{isa} extensions and knowledge of \\ac{fpu} design in order to achieve "
        "over 90\\% \\ac{fpu} occupancy for the MatMul kernel, "
        "operating on 1$\\times$200 and 200$\\times$5 64-bit inputs. "
        "Incrementally adding each optimization minimizes and, "
        "eventually eliminates, explicit memory operations, while reducing "
        "execution time (cycles) and maximizing \\ac{fpu} utilization."
    )
    latex_table += "}\n\\label{tab:opt_pipeline}\n"

    latex_table += (
        "\\centering\n\\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}}"
        + " ".join(f"{col_alignment[col]}" for col in opt_pipeline_df.columns)
        + "}\n\\toprule\n"
    )

    latex_table += "\\textbf{Optimizations} & \\multicolumn{2}{r}{\\textbf{Allocated Registers (\\#)}} & \\multicolumn{4}{c}{\\textbf{Assembly Operations (\\#)}} & \\multicolumn{2}{c}{\\textbf{Performance}}\\\\\n"

    latex_table += "\\cmidrule{2-3}\\cmidrule{4-7}\\cmidrule{8-9}\n"

    latex_table += (
        " & ".join(f"\\textbf{{{col_names[col]}}}" for col in opt_pipeline_df.columns)
        + " \\\\\n\\midrule\n"
    )

    string_table = []

    # Add the rest of the rows
    for _, row in opt_pipeline_df.iterrows():
        string_table.append([str(x) for x in row])

    # replace text for last row in the first column
    string_table[-1][0] = "+ Unroll-and-Jam"

    # change text style for first column
    for row in string_table:
        row[0] = f"\\texttt{{{row[0]}}}"

        # replace text for baseline which should be at the first row and column
        string_table[0][0] = "Baseline (for MatMul)"

    # add max register count for fp registers
    for row in string_table:
        row[1] = row[1] + "\\textcolor{lightgray}{/20}"

    # add max register count for int registers
    for row in string_table:
        row[2] = row[2] + "\\textcolor{lightgray}{/15}"

        # replace text for baseline which should be at the first row and column
        string_table[0][0] = "Baseline (for MatMul)"

    # gray out baseline which should be the first line
    for idx, val in enumerate(string_table[0]):
        string_table[0][idx] = "\\color{gray} " + val

    # highlight rightmost entry which should be the max FPU util achieved
    string_table[-1][-1] = "\\textbf{" + string_table[-1][-1] + "}"

    for row in string_table:
        latex_table += " & ".join(val for val in row) + " \\\\\n"

    latex_table += "\\bottomrule\n"

    latex_table += "\\end{tabular*}\n"

    latex_table += "\\end{table*}\n"

    return latex_table
