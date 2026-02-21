JOBS ?= all

THIS := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

IMAGE ?= snitch-toolchain

.PHONY: default
default: fast

.PHONY: artifact
artifact: fast all low_level_representation pipeline

.PHONY: fast
fast:
	snakemake --cores $(JOBS) --rerun-incomplete fast

.PHONY: all
all:
	snakemake --cores $(JOBS) --rerun-incomplete all

.PHONY: low_level_representation
low_level_representation:
	snakemake --cores $(JOBS) --rerun-incomplete low_level_representation

.PHONY: pipeline
pipeline:
	snakemake --cores $(JOBS) --rerun-incomplete pipeline

.PHONY: clean
clean:
	snakemake --delete-all-output --rerun-incomplete fast all pipeline low_level_representation

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE) -f docker/Dockerfile .

.PHONY: docker-run
docker-run:
	docker run --rm -ti --volume $(CURDIR):/src $(IMAGE) $(or $(CMD),bash)
