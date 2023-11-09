
include ../snitch/Makefile.rules

# Top-level result, pivots the flat results in kernels.csv

pivoted.csv: kernels.csv
	python3 ../scripts/pivot.py

# kernels.csv is the aggregation of all kernels

FOLDERS =
FOLDERS += conv2d_d1_s1_3x3
FOLDERS += dense
FOLDERS += dsum
FOLDERS += fill
FOLDERS += matmul
FOLDERS += pooling_nchw_max_d1_s2_3x3
FOLDERS += pooling_nchw_sum_d1_s2_3x3
FOLDERS += relu
FOLDERS += softmax

kernels.csv: $(addsuffix /params.csv, $(FOLDERS))
	./generate_params_csv.sh $@ $(addprefix ./, $^)

# individual tests below

CONV_8 = conv2d_d1_s1_3x3/1x8x8x1xf64

CONV_8_TESTS =
CONV_8_TESTS += $(CONV_8)/baseline.csv
CONV_8_TESTS += $(CONV_8)/linalg.csv

$(CONV_8)/tests.csv: $(CONV_8_TESTS)
	./generate_tests_csv.sh $@ $^

conv2d_d1_s1_3x3/params.csv: $(CONV_8)/tests.csv
	./generate_params_csv.sh $@ $^


DENSE_8 = dense/8x8xf64

DENSE_8_TESTS =
DENSE_8_TESTS += $(DENSE_8)/baseline.csv
DENSE_8_TESTS += $(DENSE_8)/fused.csv
DENSE_8_TESTS += $(DENSE_8)/linalg.csv

$(DENSE_8)/tests.csv: $(DENSE_8_TESTS)
	./generate_tests_csv.sh $@ $^

dense/params.csv: $(DENSE_8)/tests.csv
	./generate_params_csv.sh $@ $^


DSUM_8_16 = dsum/8x16xf32

DSUM_8_16_TESTS =
DSUM_8_16_TESTS += $(DSUM_8_16)/baseline.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/linalg.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/snrt.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/ssr1d.csv
DSUM_8_16_TESTS += $(DSUM_8_16)/ssr2d.csv

$(DSUM_8_16)/tests.csv: $(DSUM_8_16_TESTS)
	./generate_tests_csv.sh $@ $^

dsum/params.csv: $(DSUM_8_16)/tests.csv
	./generate_params_csv.sh $@ $^


MATMUL_8 = matmul/8x8xf64

MATMUL_8_TESTS =
MATMUL_8_TESTS += $(MATMUL_8)/baseline.csv
MATMUL_8_TESTS += $(MATMUL_8)/linalg.csv

$(MATMUL_8)/tests.csv: $(MATMUL_8_TESTS)
	./generate_tests_csv.sh $@ $^

matmul/params.csv: $(MATMUL_8)/tests.csv
	./generate_params_csv.sh $@ $^


MAX_POOL_16 = pooling_nchw_max_d1_s2_3x3/1x16x16x1xf64

MAX_POOL_16_TESTS =
MAX_POOL_16_TESTS += $(MAX_POOL_16)/baseline.csv
MAX_POOL_16_TESTS += $(MAX_POOL_16)/linalg.csv

$(MAX_POOL_16)/tests.csv: $(MAX_POOL_16_TESTS)
	./generate_tests_csv.sh $@ $^

pooling_nchw_max_d1_s2_3x3/params.csv: $(MAX_POOL_16)/tests.csv
	./generate_params_csv.sh $@ $^


SUM_POOL_16 = pooling_nchw_sum_d1_s2_3x3/1x16x16x1xf64

SUM_POOL_16_TESTS =
SUM_POOL_16_TESTS += $(SUM_POOL_16)/baseline.csv
SUM_POOL_16_TESTS += $(SUM_POOL_16)/linalg.csv

$(SUM_POOL_16)/tests.csv: $(SUM_POOL_16_TESTS)
	./generate_tests_csv.sh $@ $^

pooling_nchw_sum_d1_s2_3x3/params.csv: $(SUM_POOL_16)/tests.csv
	./generate_params_csv.sh $@ $^


RELU_16 = relu/16x16xf64

RELU_16_TESTS =
RELU_16_TESTS += $(RELU_16)/baseline.csv
RELU_16_TESTS += $(RELU_16)/ssr.csv
RELU_16_TESTS += $(RELU_16)/ssr_frep.csv
RELU_16_TESTS += $(RELU_16)/snrt.csv
RELU_16_TESTS += $(RELU_16)/linalg.csv
RELU_16_TESTS += $(RELU_16)/snitch_stream.csv

$(RELU_16)/tests.csv: $(RELU_16_TESTS)
	./generate_tests_csv.sh $@ $^

relu/params.csv: $(RELU_16)/tests.csv
	./generate_params_csv.sh $@ $^

FILL_16 = fill/16x16xf64

FILL_16_TESTS =
FILL_16_TESTS += $(FILL_16)/baseline.csv
FILL_16_TESTS += $(FILL_16)/linalg.csv

$(FILL_16)/tests.csv: $(FILL_16_TESTS)
	./generate_tests_csv.sh $@ $^

fill/params.csv: $(FILL_16)/tests.csv
	./generate_params_csv.sh $@ $^


SOFTMAX_16 = softmax/16xf64

SOFTMAX_16_TESTS =
SOFTMAX_16_TESTS += $(SOFTMAX_16)/baseline.csv

$(SOFTMAX_16)/tests.csv: $(SOFTMAX_16_TESTS)
	./generate_tests_csv.sh $@ $^

softmax/params.csv: $(SOFTMAX_16)/tests.csv
	./generate_params_csv.sh $@ $^
