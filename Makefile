JOBS ?= all

THIS := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: all clean

all:
	snakemake -d $(THIS)/kernels -s $(THIS)/kernels/Snakefile --cores $(JOBS) --rerun-incomplete

clean:
	snakemake -d $(THIS)/kernels -s $(THIS)/kernels/Snakefile --delete-all-output --rerun-incomplete
