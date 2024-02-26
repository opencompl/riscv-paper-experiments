import pandas as pd
import sys
import os


def concatenate_csv(output_path, input_paths):
    # Initialize an empty DataFrame
    output_df = pd.DataFrame()

    # Iterate over input files
    for file in input_paths:
        # Read each file into a DataFrame
        df = pd.read_csv(file)

        # Extract filename without extension
        filename = os.path.splitext(os.path.basename(file))[0]

        # Add "tests" column with filename as value
        df.insert(0, "tests", filename)

        # Concatenate with existing data
        output_df = pd.concat([output_df, df], ignore_index=True, sort=False)

    # Create the union of all headers
    headers = output_df.columns.tolist()

    # Write output dataframe to file
    output_df.to_csv(output_path, index=False, header=headers)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(
            "Usage: {} <output_path> <input_path1> [<input_path2> ...]".format(
                sys.argv[0]
            )
        )
        sys.exit(1)
    output_path = sys.argv[1]
    input_paths = sys.argv[2:]
    concatenate_csv(output_path, input_paths)
