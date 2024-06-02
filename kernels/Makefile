
include ../snitch/Makefile.rules

.PHONY: clean, bla

# Top-level result, pivots the flat results in kernels.csv

pivoted.csv pivoted_ipc.csv pivoted_fpu.csv: kernels.csv ../scripts/pivot.py
	python3 ../scripts/pivot.py

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


MAX_POOL_16 = pooling_nchw_max_d1_s2_3x3/1x1x16x16xf64

MAX_POOL_16_TESTS =
MAX_POOL_16_TESTS += $(MAX_POOL_16)/baseline.csv
MAX_POOL_16_TESTS += $(MAX_POOL_16)/linalg.csv
MAX_POOL_16_TESTS += $(MAX_POOL_16)/snitch_stream.csv
MAX_POOL_16_TESTS += $(MAX_POOL_16)/snrt.csv
# spill to j register...
# MAX_POOL_16_TESTS += $(MAX_POOL_16)/scf_xdsl.csv

$(MAX_POOL_16)/tests.csv: $(MAX_POOL_16_TESTS)
	python3 generate_tests.py $@ $^

pooling_nchw_max_d1_s2_3x3/params.csv: $(MAX_POOL_16)/tests.csv
	python3 generate_params.py "params" $@ $^


SUM_POOL_16 = pooling_nchw_sum_d1_s2_3x3/1x1x16x16xf64

SUM_POOL_16_TESTS =
SUM_POOL_16_TESTS += $(SUM_POOL_16)/baseline.csv
SUM_POOL_16_TESTS += $(SUM_POOL_16)/linalg.csv
SUM_POOL_16_TESTS += $(SUM_POOL_16)/snitch_stream.csv
SUM_POOL_16_TESTS += $(SUM_POOL_16)/snrt.csv
# spill to j register...
# SUM_POOL_16_TESTS += $(SUM_POOL_16)/scf_xdsl.csv

$(SUM_POOL_16)/tests.csv: $(SUM_POOL_16_TESTS)
	python3 generate_tests.py $@ $^

pooling_nchw_sum_d1_s2_3x3/params.csv: $(SUM_POOL_16)/tests.csv
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


CLEAN_PATH = .

# Remove all csv files in this folder, recursively
clean:
	find $(CLEAN_PATH) -type f -name "*.csv" -print0 | xargs -0 rm -f
	find $(CLEAN_PATH) -type f -name "*.x" -print0 | xargs -0 rm -f
	find $(CLEAN_PATH) -type d -name "*.x.logs" -print0 | xargs -0 rm -rf
	find $(CLEAN_PATH) -type f -name "*.S" -print0 | xargs -0 rm -f
	find $(CLEAN_PATH) -type f -name "*.bc" -print0 | xargs -0 rm -f
	find $(CLEAN_PATH) -type f -name "*.ll" -print0 | xargs -0 rm -f
	find $(CLEAN_PATH) -type f -name "*.ll.mlir" -print0 | xargs -0 rm -f
	@for folder in $(GEN_MAIN); do \
		find $$folder -type d -print0 | xargs -0 rm -rf; \
	done
