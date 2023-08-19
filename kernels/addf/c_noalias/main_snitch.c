#include "addf.h"
#include "data.h"
#include "diff.h"

#include <snitch/runtime.h>

#include <stddef.h>
#include <stdint.h>

int main(void) {
    const uint32_t test_core_idx = 0u;
    const uint32_t core_idx = snrt_cluster_compute_core_idx();
    if (core_idx != test_core_idx) return 0;
    float* a = snrt_l1alloc(M * N * sizeof(float));
    if (a == NULL) return 1;
    addf(a, B);
    uint32_t ndiff = diff(a, A_PLUS_B, 0.001f /*should be proper eps*/);
    return (int)ndiff;
}
