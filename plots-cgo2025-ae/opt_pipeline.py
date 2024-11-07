import pandas as pd

col_names = {
    'Optimizations': '',
    'F Registers': 'FP',
    'X Registers': 'Integer',
    'F Loads': 'Loads',
    'F Stores': 'Stores',
    'FMAdd': 'FMAdd',
    'FRep': 'FRep',
    'Cycles': 'Cycles (#)',
    'Occupancy': 'Occupancy (%)',
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
    csv_table = ""

    csv_table += "Optimizations, Allocated Registers (#),  Assembly Operations (#) , Performance\\n"

    csv_table += " , ".join(f"{col_names[col]}" for col in opt_pipeline_df.columns)

    string_table = []

    # Add the rest of the rows
    for _, row in opt_pipeline_df.iterrows():
        string_table.append([str(x) for x in row])

    # replace text for last row in the first column
    string_table[-1][0] = "+ Unroll-and-Jam"

    # change text style for first column
    for row in string_table:
        # replace text for baseline which should be at the first row and column
        string_table[0][0] = "Baseline (for MatMul)"

    # add max register count for fp registers
    for row in string_table:
        row[1] = row[1] + "/20"

    # add max register count for int registers
    for row in string_table:
        row[2] = row[2] + "/15"

    for row in string_table:
        csv_table += " , ".join(val for val in row) + " \\n"

    return csv_table
