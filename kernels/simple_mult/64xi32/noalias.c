#include "data.h"

#include <snrt.h>

#include <stdint.h>

void simple_mult(const int32_t * restrict A, const int32_t * restrict B, int32_t * restrict D) {
    const uint32_t n = N;
    for (uint32_t i = 0; i < n; ++i) {
        D[i] = A[i] * B[i];
    }
}
