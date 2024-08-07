JOBS ?= all

THIS := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: default fast all clean

default: fast

fast: maybe_update_xdsl_commit
	snakemake --cores $(JOBS) --rerun-incomplete fast

all: maybe_update_xdsl_commit
	snakemake --cores $(JOBS) --rerun-incomplete all

clean:
	snakemake --delete-all-output --rerun-incomplete fast all

include ./Makefile.xdsl
