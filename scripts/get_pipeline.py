from pathlib import Path

from xdsl.transforms.test_lower_linalg_to_snitch import TEST_LOWER_LINALG_TO_SNITCH_PASSES


def print_optimization_pipelines(opt_passes: list[str]):
    opt_passes_set = set(opt_passes)
    all_passes = [str(p.pipeline_pass_spec()) for p in TEST_LOWER_LINALG_TO_SNITCH_PASSES]

    assert opt_passes_set.issubset(all_passes)

    for i in range(len(opt_passes) + 1):
        opt_passes_subset = set(opt_passes[i:])
        # print(opt_passes[:i])
        filtered_passes = [
            p for p in all_passes
            if p not in opt_passes_subset
        ]
        print(",".join(filtered_passes))


def main():
    import argparse

    parser = argparse.ArgumentParser(description="Get pipeline passes")
    parser.add_argument('opt_passes', type=Path, help='Path to the optimization passes file')

    args = parser.parse_args()
    with open(args.opt_passes) as file:
        opt_passes = file.read().splitlines()

    print_optimization_pipelines(opt_passes)

if __name__ == "__main__":
    main()
