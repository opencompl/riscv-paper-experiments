JOBS ?= all

THIS := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: default fast all clean artifact

default: fast

artifact: fast all low_level_representation pipeline

fast: requirements.txt
	snakemake --cores $(JOBS) --rerun-incomplete fast

all: requirements.txt
	snakemake --cores $(JOBS) --rerun-incomplete all

low_level_representation: requirements.txt
	snakemake --cores $(JOBS) --rerun-incomplete low_level_representation

pipeline: requirements.txt
	snakemake --cores $(JOBS) --rerun-incomplete pipeline

clean:
	snakemake --delete-all-output --rerun-incomplete fast all pipeline low_level_representation
