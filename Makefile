JOBS ?= all

THIS := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: default fast all clean artifact low_level_representation pipeline cost_model

default: fast

artifact: fast all low_level_representation pipeline

fast: maybe_update_xdsl_commit
	snakemake --cores $(JOBS) --rerun-incomplete fast

all: maybe_update_xdsl_commit
	snakemake --cores $(JOBS) --rerun-incomplete all

low_level_representation: maybe_update_xdsl_commit
	snakemake --cores $(JOBS) --rerun-incomplete low_level_representation

pipeline: maybe_update_xdsl_commit
	snakemake --cores $(JOBS) --rerun-incomplete pipeline

cost_model: maybe_update_xdsl_commit
	snakemake --cores $(JOBS) --rerun-incomplete cost_model

clean:
	snakemake --delete-all-output --rerun-incomplete fast all pipeline low_level_representation cost_model

include ./Makefile.xdsl
