JOBS ?= all

THIS := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: default fast all clean

default: fast

fast:
	snakemake -d $(THIS)/kernels -s $(THIS)/kernels/Snakefile --cores $(JOBS) --rerun-incomplete fast

all:
	snakemake -d $(THIS)/kernels -s $(THIS)/kernels/Snakefile --cores $(JOBS) --rerun-incomplete all

clean:
	snakemake -d $(THIS)/kernels -s $(THIS)/kernels/Snakefile --delete-all-output --rerun-incomplete fast all
