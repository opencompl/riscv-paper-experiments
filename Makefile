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

.PHONY: exp_micro
exp_micro:
	snakemake --cores $(JOBS) --rerun-incomplete exp_micro
	python plots-mia-thesis/plot_exp_accuracy.py -o plots-mia-thesis/output/exp_accuracy.pdf
	python plots-mia-thesis/plot_exp_accuracy_chebyshev.py -o plots-mia-thesis/output/exp_accuracy_chebyshev.pdf
	python plots-mia-thesis/plot_exp_micro_bar.py --input results/kernels.exp_micro.csv --output plots-mia-thesis/output/exp_bar_plots.pdf

.PHONY: exp_macro
exp_macro:
	snakemake --cores $(JOBS) --rerun-incomplete exp_macro
	python plots-mia-thesis/plot_exp_macro.py --input results/kernels.exp_macro.csv --output plots-mia-thesis/output/exp_macro_plots.pdf

.PHONY: exp
exp:
	snakemake --cores $(JOBS) --rerun-incomplete exp_micro exp_macro

.PHONY: clean
clean:
	snakemake --delete-all-output --rerun-incomplete fast all pipeline low_level_representation exp_micro exp_macro

.PHONY: docker-build
docker-build:
	@PLATFORM_FLAG="" ; \
	if [ "$$(uname -s)" = "Darwin" ]; then \
		PLATFORM_FLAG="--platform linux/amd64" ; \
	fi ; \
	docker build $$PLATFORM_FLAG -t $(IMAGE) -f docker/Dockerfile .

.PHONY: docker-run
docker-run:
	@PLATFORM_FLAG="" ; \
	if [ "$$(uname -s)" = "Darwin" ]; then \
		PLATFORM_FLAG="--platform linux/amd64" ; \
	fi ; \
	docker run $$PLATFORM_FLAG --rm -ti --volume $(CURDIR):/src $(IMAGE) $(or $(CMD),bash)
