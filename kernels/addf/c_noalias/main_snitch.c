#include "addf.h"
#include "data.h"
#include "diff.h"

#include <snitch/runtime.h>
#include <snitch/perf_cnt.h>

#include <stddef.h>
#include <stdint.h>

int main(void) {
    const uint32_t test_core_idx = 0u;
    const uint32_t core_idx = snrt_cluster_compute_core_idx();
    if (core_idx != test_core_idx) return 0;
    float* a = snrt_l1alloc(M * N * sizeof(float));
    if (a == NULL) return 1;
    (void)snrt_memcpy(a, A, M * N * sizeof(float));
    uint32_t cycles_start = snrt_get_perf_counter(SNRT_PERF_CNT0);
    uint32_t retired_start = snrt_get_perf_counter(SNRT_PERF_CNT1);
    printf("start: %d, %d\n", cycles_start, retired_start);
    snrt_start_perf_counter(SNRT_PERF_CNT0, SNRT_PERF_CNT_CYCLES, test_core_idx);
    snrt_start_perf_counter(SNRT_PERF_CNT1, SNRT_PERF_CNT_RETIRED_INSTR, test_core_idx);
    addf(a, B);
    snrt_stop_perf_counter(SNRT_PERF_CNT0);
    snrt_stop_perf_counter(SNRT_PERF_CNT1);
    uint32_t cycles_stop = snrt_get_perf_counter(SNRT_PERF_CNT0);
    uint32_t retired_stop = snrt_get_perf_counter(SNRT_PERF_CNT1);
    printf("end: %d, %d\n", cycles_stop, retired_stop);
    uint32_t ndiff = diff(a, A_PLUS_B, 0.001f /*should be proper eps*/);
    return (int)ndiff;
}
