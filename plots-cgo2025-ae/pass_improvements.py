#!/usr/bin/env python3
import pandas as pd
import argparse


def extract(df):
    mask = df["impl"].str.contains(r"linalg_\d_xdsl|linalg_full_xdsl", regex=True)
    return df[mask]


def pass_order_mapping(n_passes=10):
    custom_order = [f"linalg_{i}_xdsl" for i in range(n_passes)] + ["linalg_full_xdsl"]
    return {name: index for index, name in enumerate(custom_order)}


def add_linalg_passes(data):
    df = data.copy()
    # Pass order
    df["linalg_pass_order"] = df["impl"].map(pass_order_mapping())
    df = df.sort_values(by=["test", "params", "linalg_pass_order"])
    # fpss_fpu_occupancy relative improvement
    df["linalg_pass_relative_improvement"] = (
        df.groupby(["test", "params"])["fpss_fpu_occupancy"].diff().fillna(0)
    )
    # group min/max/delta
    group_max = df.groupby(["test", "params"])["fpss_fpu_occupancy"].max().reset_index()
    group_max = group_max.rename(
        columns={"fpss_fpu_occupancy": "linalg_pass_group_max"}
    )
    group_min = df.groupby(["test", "params"])["fpss_fpu_occupancy"].min().reset_index()
    group_min = group_min.rename(
        columns={"fpss_fpu_occupancy": "linalg_pass_group_min"}
    )
    group_delta = pd.merge(group_min, group_max, on=["test", "params"])
    group_delta["linalg_pass_group_delta"] = (
        group_delta["linalg_pass_group_max"] - group_delta["linalg_pass_group_min"]
    )
    # overall pass % contribution
    df = pd.merge(df, group_delta, on=["test", "params"])
    df["linalg_pass_%_contribution"] = (
        df["linalg_pass_relative_improvement"].abs()
        / df["linalg_pass_group_delta"].abs()
    )
    return df


def get_pass_contributions_table(df):
    pivot_df = df.pivot(
        index=["test", "params"], columns="impl", values="linalg_pass_%_contribution"
    )
    pivot_df.columns.name = None
    pivot_df.reset_index(inplace=True)
    return pivot_df


def main():
    parser = argparse.ArgumentParser(
        description="Generate pass improvements CSV table."
    )
    parser.add_argument("csv_file", help="Path to the input CSV file")
    args = parser.parse_args()
    data = pd.read_csv(args.csv_file)
    df = extract(data)
    df = add_linalg_passes(df)
    df = get_pass_contributions_table(df)
    print(df.to_csv(index=False))


if __name__ == "__main__":
    main()
