
include ../snitch/Makefile.rules

.PHONY: clean

# Top-level result, pivots the flat results in kernels.csv

pivoted.csv pivoted_fpu.csv: kernels.csv ../scripts/pivot.py
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


DSUM_8_16 = dsum/8x16xf32

DSUM_8_16_TESTS =
DSUM_8_16_TESTS += $(DSUM_8_16)/baseline.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/linalg.csv
# DSUM_8_16_TESTS += $(DSUM_8_16)/linalg_xdsl.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/snrt.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/ssr1d.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/ssr2d.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/snitch_stream.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/scf_xdsl.csv

$(DSUM_8_16)/tests.csv: $(DSUM_8_16_TESTS)
	python3 generate_tests.py $@ $^

dsum/params.csv: $(DSUM_8_16)/tests.csv
	python3 generate_params.py "params" $@ $^


MATMUL_8 = matmul/8x8xf64

MATMUL_8_TESTS =
MATMUL_8_TESTS += $(MATMUL_8)/baseline.csv
MATMUL_8_TESTS += $(MATMUL_8)/linalg.csv
MATMUL_8_TESTS += $(MATMUL_8)/snitch_stream.csv
MATMUL_8_TESTS += $(MATMUL_8)/snrt.csv
MATMUL_8_TESTS += $(MATMUL_8)/scf_xdsl.csv

$(MATMUL_8)/tests.csv: $(MATMUL_8_TESTS)
	python3 generate_tests.py $@ $^

matmul/params.csv: $(MATMUL_8)/tests.csv
	python3 generate_params.py "params" $@ $^


MAX_POOL_16 = pooling_nchw_max_d1_s2_3x3/1x1x16x16xf64

MAX_POOL_16_TESTS =
MAX_POOL_16_TESTS += $(MAX_POOL_16)/baseline.csv
MAX_POOL_16_TESTS += $(MAX_POOL_16)/linalg.csv
MAX_POOL_16_TESTS += $(MAX_POOL_16)/snitch_stream.csv
MAX_POOL_16_TESTS += $(MAX_POOL_16)/snrt.csv
# maxf renamed in MLIR 17
MAX_POOL_16_TESTS += $(MAX_POOL_16)/scf_xdsl.csv

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
SUM_POOL_16_TESTS += $(SUM_POOL_16)/scf_xdsl.csv

$(SUM_POOL_16)/tests.csv: $(SUM_POOL_16_TESTS)
	python3 generate_tests.py $@ $^

pooling_nchw_sum_d1_s2_3x3/params.csv: $(SUM_POOL_16)/tests.csv
	python3 generate_params.py "params" $@ $^


RELU_16 = relu/16x16xf64

RELU_16_TESTS =
RELU_16_TESTS += $(RELU_16)/baseline.csv
RELU_16_TESTS += $(RELU_16)/ssr.csv
RELU_16_TESTS += $(RELU_16)/ssr_frep.csv
RELU_16_TESTS += $(RELU_16)/snrt.csv
RELU_16_TESTS += $(RELU_16)/linalg.csv
# RELU_16_TESTS += $(RELU_16)/linalg_xdsl.csv
RELU_16_TESTS += $(RELU_16)/snitch_stream.csv
# maxf renamed in MLIR 17
RELU_16_TESTS += $(RELU_16)/scf_xdsl.csv

$(RELU_16)/tests.csv: $(RELU_16_TESTS)
	python3 generate_tests.py $@ $^

relu/params.csv: $(RELU_16)/tests.csv
	python3 generate_params.py "params" $@ $^

FILL_16 = fill/16x16xf64

FILL_16_TESTS =
FILL_16_TESTS += $(FILL_16)/baseline.csv
FILL_16_TESTS += $(FILL_16)/linalg.csv
FILL_16_TESTS += $(FILL_16)/snitch_stream.csv
FILL_16_TESTS += $(FILL_16)/snrt.csv
FILL_16_TESTS += $(FILL_16)/scf_xdsl.csv


$(FILL_16)/tests.csv: $(FILL_16_TESTS)
	python3 generate_tests.py $@ $^

fill/params.csv: $(FILL_16)/tests.csv
	python3 generate_params.py "params" $@ $^

