
include ../snitch/Makefile.rules

.PHONY: clean

# Top-level result, pivots the flat results in kernels.csv

pivoted.csv pivoted_ipc.csv pivoted_fpu.csv: kernels.csv ../scripts/pivot.py
	python3 ../scripts/pivot.py

# Remove all csv files in this folder, recursively
clean:
	find . -type f -name "*.csv" -print0 | xargs -0 rm -f
	find . -type f -name "*.x" -print0 | xargs -0 rm -f
	find . -type d -name "*.x.logs" -print0 | xargs -0 rm -rf
	find . -type f -name "*.S" -print0 | xargs -0 rm -f
	find . -type f -name "*.bc" -print0 | xargs -0 rm -f
	find . -type f -name "*.ll" -print0 | xargs -0 rm -f
	find . -type f -name "*.ll.mlir" -print0 | xargs -0 rm -f

# kernels.csv is the aggregation of all kernels

FOLDERS =
FOLDERS += conv2d_d1_s1_3x3
FOLDERS += ddot
FOLDERS += dense
FOLDERS += dsum
FOLDERS += fill
FOLDERS += matmul
FOLDERS += pooling_nchw_max_d1_s2_3x3
FOLDERS += pooling_nchw_sum_d1_s2_3x3
FOLDERS += relu

kernels.csv: $(addsuffix /params.csv, $(FOLDERS))
	python3 generate_params.py "test" $@ $(addprefix ./, $^)

# individual tests below

CONV_8 = conv2d_d1_s1_3x3/1x1x8x8xf64

CONV_8_TESTS =
CONV_8_TESTS += $(CONV_8)/baseline.csv
CONV_8_TESTS += $(CONV_8)/linalg.csv
CONV_8_TESTS += $(CONV_8)/snitch_stream.csv
CONV_8_TESTS += $(CONV_8)/snrt.csv
# spill to j register...
# CONV_8_TESTS += $(CONV_8)/scf_xdsl.csv

$(CONV_8)/tests.csv: $(CONV_8_TESTS)
	python3 generate_tests.py $@ $^

conv2d_d1_s1_3x3/params.csv: $(CONV_8)/tests.csv
	python3 generate_params.py "params" $@ $^


DDOT_128 = ddot/128xf64

DDOT_128_TESTS =
DDOT_128_TESTS += $(DDOT_128)/baseline.csv
DDOT_128_TESTS += $(DDOT_128)/linalg.csv
DDOT_128_TESTS += $(DDOT_128)/snitch_stream.csv
DDOT_128_TESTS += $(DDOT_128)/snrt.csv
DDOT_128_TESTS += $(DDOT_128)/scf_xdsl.csv
DDOT_128_TESTS += $(DDOT_128)/scf.csv

$(DDOT_128)/tests.csv: $(DDOT_128_TESTS)
	python3 generate_tests.py $@ $^

ddot/params.csv: $(DDOT_128)/tests.csv
	python3 generate_params.py "params" $@ $^

DENSE_8 = dense/8x8xf64

DENSE_8_TESTS =
DENSE_8_TESTS += $(DENSE_8)/baseline.csv
DENSE_8_TESTS += $(DENSE_8)/fused.csv
DENSE_8_TESTS += $(DENSE_8)/linalg.csv
DENSE_8_TESTS += $(DENSE_8)/snrt.csv
DENSE_8_TESTS += $(DENSE_8)/snitch_stream.csv
# spill to j register...
# DENSE_8_TESTS += $(DENSE_8)/scf_xdsl.csv

$(DENSE_8)/tests.csv: $(DENSE_8_TESTS)
	python3 generate_tests.py $@ $^

dense/params.csv: $(DENSE_8)/tests.csv
	python3 generate_params.py "params" $@ $^


GEN_PARAMS_LINALG =
GEN_PARAMS_SNITCH_STREAM =

# Triple for loop macro to generate matmul kernel sizes
define generate_folders_matmul

MATMUL_PARAMS += matmul/$(1)x$(2)x$(3)xf64

# Rule to generate JSON file
matmul/$(1)x$(2)x$(3)xf64/params.json: | matmul/$(1)x$(2)x$(3)xf64
	@echo '{\n\
	\t"M": $(1),\n\
	\t"K": $(2),\n\
	\t"N": $(3),\n\
	\t"rmin": -1000.0,\n\
	\t"rmax": 1000.0,\n\
	\t"precision": 64\n\
	}' > $$@

endef

RANGE_4_4_8 := $(shell seq 4 4 8)

$(foreach M,$(RANGE_4_4_8),\
	$(foreach K,$(RANGE_4_4_8),\
		$(foreach N,$(RANGE_4_4_8),\
			$(eval $(call generate_folders_matmul,$(M),$(K),$(N)))\
		)\
	)\
)

GEN_PARAMS_SNITCH_STREAM += $(MATMUL_PARAMS)

matmul/params.csv: $(patsubst %,%/tests.csv,$(MATMUL_PARAMS))
	python3 generate_params.py "params" $@ $^

# Double for loop macro to generate sum pool kernel sizes
define generate_folders_sum_pool

GEN_PARAMS_SUM_POOL += pooling_nchw_sum_d1_s2_3x3/$(1)x$(2)xf64

# Rule to generate JSON file
pooling_nchw_sum_d1_s2_3x3/$(1)x$(2)xf64/params.json: | pooling_nchw_sum_d1_s2_3x3/$(1)x$(2)xf64
	@echo '{\n\
	\t"H": $(1),\n\
	\t"W": $(2),\n\
	\t"rmin": -1000.0,\n\
	\t"rmax": 1000.0,\n\
	\t"precision": 64\n\
	}' > $$@

endef

# 3x3 pool with stride 2 means that the dimensions we want to explore are (8k + 2)
RANGE_10_8_18 := $(shell seq 10 8 18)

$(foreach H,$(RANGE_10_8_18),\
	$(foreach W,$(RANGE_10_8_18),\
		$(eval $(call generate_folders_sum_pool,$(H),$(W)))\
	)\
)

GEN_PARAMS_SNITCH_STREAM += $(GEN_PARAMS_SUM_POOL)

pooling_nchw_sum_d1_s2_3x3/params.csv: $(patsubst %,%/tests.csv,$(GEN_PARAMS_SUM_POOL))
	python3 generate_params.py "params" $@ $^

# Double for loop macro to generate max pool kernel sizes
define generate_folders_max_pool

GEN_PARAMS_MAX_POOL += pooling_nchw_max_d1_s2_3x3/$(1)x$(2)xf64

# Rule to generate JSON file
pooling_nchw_max_d1_s2_3x3/$(1)x$(2)xf64/params.json: | pooling_nchw_max_d1_s2_3x3/$(1)x$(2)xf64
	@echo '{\n\
	\t"H": $(1),\n\
	\t"W": $(2),\n\
	\t"rmin": -1000.0,\n\
	\t"rmax": 1000.0,\n\
	\t"precision": 64\n\
	}' > $$@

endef

# 3x3 pool with stride 2 means that the dimensions we want to explore are (8k + 2)
RANGE_10_8_18 := $(shell seq 10 8 18)

$(foreach H,$(RANGE_10_8_18),\
	$(foreach W,$(RANGE_10_8_18),\
		$(eval $(call generate_folders_max_pool,$(H),$(W)))\
	)\
)

GEN_PARAMS_SNITCH_STREAM += $(GEN_PARAMS_MAX_POOL)

pooling_nchw_max_d1_s2_3x3/params.csv: $(patsubst %,%/tests.csv,$(GEN_PARAMS_MAX_POOL))
	python3 generate_params.py "params" $@ $^

define generate_folders_dsum

GEN_PARAMS_DSUM += dsum/$(1)x$(2)xf64

# Rule to generate JSON file
dsum/$(1)x$(2)xf64/params.json: | dsum/$(1)x$(2)xf64
	@echo '{\n\
	\t"M": $(1),\n\
	\t"N": $(2),\n\
	\t"rmin": -1000.0,\n\
	\t"rmax": 1000.0,\n\
	\t"precision": 64\n\
	}' > $$@

endef

RANGE_4_4_16 := $(shell seq 4 4 16)

$(foreach M,$(RANGE_4_4_16),\
	$(foreach N,$(RANGE_4_4_16),\
		$(eval $(call generate_folders_dsum,$(M),$(N)))\
	)\
)

GEN_PARAMS_LINALG += $(GEN_PARAMS_DSUM)

dsum/params.csv: $(patsubst %,%/tests.csv,$(GEN_PARAMS_DSUM))
	python3 generate_params.py "params" $@ $^

define generate_folders_fill

GEN_PARAMS_FILL += fill/$(1)x$(2)xf64

# Rule to generate JSON file
fill/$(1)x$(2)xf64/params.json: | fill/$(1)x$(2)xf64
	@echo '{\n\
	\t"M": $(1),\n\
	\t"N": $(2),\n\
	\t"rmin": -1000.0,\n\
	\t"rmax": 1000.0,\n\
	\t"precision": 64\n\
	}' > $$@

endef

RANGE_4_4_16 := $(shell seq 4 4 16)

$(foreach M,$(RANGE_4_4_16),\
	$(foreach N,$(RANGE_4_4_16),\
		$(eval $(call generate_folders_fill,$(M),$(N)))\
	)\
)

GEN_PARAMS_LINALG += $(GEN_PARAMS_FILL)

fill/params.csv: $(patsubst %,%/tests.csv,$(GEN_PARAMS_FILL))
	python3 generate_params.py "params" $@ $^

define generate_folders_relu

GEN_PARAMS_RELU += relu/$(1)x$(2)xf64

# Rule to generate JSON file
relu/$(1)x$(2)xf64/params.json: | relu/$(1)x$(2)xf64
	@echo '{\n\
	\t"M": $(1),\n\
	\t"N": $(2),\n\
	\t"rmin": -1000.0,\n\
	\t"rmax": 1000.0,\n\
	\t"precision": 64\n\
	}' > $$@

endef

RANGE_4_4_16 := $(shell seq 4 4 16)

$(foreach M,$(RANGE_4_4_16),\
	$(foreach N,$(RANGE_4_4_16),\
		$(eval $(call generate_folders_relu,$(M),$(N)))\
	)\
)

GEN_PARAMS_LINALG += $(GEN_PARAMS_RELU)

relu/params.csv: $(patsubst %,%/tests.csv,$(GEN_PARAMS_RELU))
	python3 generate_params.py "params" $@ $^

GEN_PARAMS =
GEN_PARAMS += $(GEN_PARAMS_LINALG)
GEN_PARAMS += $(GEN_PARAMS_SNITCH_STREAM)

define generate_target

$(1)/data.h: $(dir $(1))data.h.template $(1)/params.json
	python /src/scripts/format.py $(dir $(1))data.h.template $(1)/params.json > $$@

$(1)/data.c: $(1)/params.json $(1)/data.h
	python -m $(patsubst %/,%.,$(dir $(1)))"gendata" -p $(1)/params.json > $$@

# Rule to create the target directory if it doesn't exist
$(1):
	@mkdir -p $(1)

endef

$(foreach param,$(GEN_PARAMS),$(eval $(call generate_target,$(param))))


define generate_target_snitch_stream

$(1)/snitch_stream.xdsl.mlir: $(dir $(1))snitch_stream.xdsl.mlir.template $(1)/params.json
	python /src/scripts/format.py $(dir $(1))snitch_stream.xdsl.mlir.template $(1)/params.json > $$@

$(1)/tests.csv: $(1)/snitch_stream.csv
	python3 generate_tests.py $$@ $(1)/snitch_stream.csv

endef

$(foreach param,$(GEN_PARAMS_SNITCH_STREAM),$(eval $(call generate_target_snitch_stream,$(param))))


define generate_target_linalg

$(1)/linalg_xdsl.xdsl.mlir: $(dir $(1))linalg_xdsl.xdsl.mlir.template $(1)/params.json
	python /src/scripts/format.py $(dir $(1))linalg_xdsl.xdsl.mlir.template $(1)/params.json > $$@

$(1)/tests.csv: $(1)/linalg_xdsl.csv
	python3 generate_tests.py $$@ $(1)/linalg_xdsl.csv

endef

$(foreach param,$(GEN_PARAMS_LINALG),$(eval $(call generate_target_linalg,$(param))))

define generate_main

$(1)/main.o: $(dir $(1))main.c $(1)/data.h
	$(CC) $(CFLAGS) -I$$(dir $$@) -c $$< -o $$@

endef


GEN_MAIN = $(GEN_PARAMS)
GEN_MAIN += $(CONV_8)
GEN_MAIN += $(DDOT_128)
GEN_MAIN += $(DENSE_8)
GEN_MAIN += $(DSUM_8_16)
GEN_MAIN += $(MAX_POOL_16)
GEN_MAIN += $(SUM_POOL_16)

$(foreach param,$(GEN_MAIN),$(eval $(call generate_main,$(param))))
