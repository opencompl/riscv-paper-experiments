#!/usr/bin/env python3

import pandas as pd
import sys
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Append columns from stdin CSV to target CSV file in-place."
    )
    parser.add_argument("target_csv", help="Target CSV file path")
    args = parser.parse_args()
    input_df = pd.read_csv(sys.stdin)
    target_df = pd.read_csv(args.target_csv)

    # Check for overlapping columns
    existing_columns = [col for col in input_df.columns if col in target_df.columns]
    if existing_columns:
        raise ValueError(
            f"Columns {', '.join(existing_columns)} already exist in target file."
        )

    target_df = pd.concat([target_df, input_df], axis=1)
    target_df.to_csv(sys.stdout, index=False)
