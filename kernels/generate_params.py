import pandas as pd
import sys
import os


def concatenate_csv(prefix: str, output_path: str, input_paths: str):
    # Initialize an empty DataFrame
    output_df = pd.DataFrame()

    # Iterate over input files
    for file in input_paths:
        # Read each file into a DataFrame
        df = pd.read_csv(file)

        # Extract parameters from file path
        pattern = os.path.basename(os.path.dirname(file))

        # Add "tests" column with filename as value
        df.insert(0, prefix, pattern)

        # Concatenate with existing data
        output_df = pd.concat([output_df, df], ignore_index=True, sort=False)

    # Create the union of all headers
    headers = output_df.columns.tolist()

    # Write output dataframe to file
    output_df.to_csv(output_path, index=False, header=headers)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(
            f"Usage: {sys.argv[0]} <prefix> <output_path> <input_path1> [<input_path2> ...]"
        )
        sys.exit(1)
    prefix = sys.argv[1]
    output_path = sys.argv[2]
    input_paths = sys.argv[3:]
    concatenate_csv(prefix, output_path, input_paths)
