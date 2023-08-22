#include "testcase.h"

#include <snitch/perf_cnt.h>
#include <snitch/runtime.h>

#include <math.h>
#include <stddef.h>
#include <stdint.h>

// Performance counters collected during test runs.
struct counters {
    uint32_t Cycles;
    uint32_t InstRetired;
    uint32_t FpInstIssued;
};

static int32_t testcase_run_args(const struct testcase* test, struct counters* cnt) {
    const size_t bytes = test->m * test->n * sizeof(float);
    // Copy test data over to L1
    float* a = snrt_l1alloc(bytes);
    if (a == NULL) return INT32_MIN;
    (void)snrt_memcpy(a, test->A, bytes);
    float* b = snrt_l1alloc(bytes);
    if (b == NULL) return INT32_MIN;
    (void)snrt_memcpy(b, test->B, bytes);
    // Start performance monitoring
    if (cnt) {
        snrt_start_perf_counter(SNRT_PERF_CNT0, SNRT_PERF_CNT_CYCLES, 0);
        snrt_start_perf_counter(SNRT_PERF_CNT1, SNRT_PERF_CNT_RETIRED_INSTR, 0);
        snrt_start_perf_counter(SNRT_PERF_CNT2, SNRT_PERF_CNT_ISSUE_FPU, 0);
    }
    //
    test->Kernel(a, b);
    // Stop performance monitoring
    if (cnt) {
        snrt_stop_perf_counter(SNRT_PERF_CNT0);
        snrt_stop_perf_counter(SNRT_PERF_CNT1);
        snrt_stop_perf_counter(SNRT_PERF_CNT2);
        cnt->Cycles = snrt_get_perf_counter(SNRT_PERF_CNT0);
        cnt->InstRetired = snrt_get_perf_counter(SNRT_PERF_CNT1);
        cnt->FpInstIssued = snrt_get_perf_counter(SNRT_PERF_CNT2);
    }
    // Sum reduce differences from expected
    int32_t ndiff = 0;
    for (uint32_t i = 0; i < test->m * test->n; ++i) {
        float value = a[i];
        float expected = test->Expected[i];
        // It looks like std fp classification functions don't work
        // on Snitch (fpclassify, isnan, etc...)
        if (value != value /*poor man's isnan()*/) goto mismatch;
        if (expected != expected /*poor man's isnan()*/) goto mismatch;
        float d = fabs(value - expected);
        if (d != d /*poor man's isnan()*/) goto mismatch;
        // Make sure to have the happy path on the taken branch
        // here, so any comparison with NaN would end up
        // counted as a difference:
        if (d <= 0.001f /*should be proper eps*/) continue;
    mismatch:
        ++ndiff;
    }
    return ndiff;
}

int32_t testcase_run(void) {
    const uint32_t thiscore = snrt_cluster_compute_core_idx();
    if (thiscore != 0u) return 0;
    struct testcase t = {0};
    testcase_get(&t);
    struct counters cnt = {0};
    int32_t ret = testcase_run_args(&t, &cnt);
    // Print results to be parsed by someone listening to stdout
    const char* outcome = ret ? "FAIL" : "PASS";
    printf("TEST %s, %d, %d, %d\n", outcome, cnt.Cycles, cnt.InstRetired,
           cnt.FpInstIssued);
    return ret;
}
