#include "data.h"

#include <snrt.h>

#include <stdint.h>

void fadd(const float* x, const float* y, float* z) {
    for (uint32_t i = 0; i < N * N; ++i) {
        z[i] = x[i] + y[i];
    }
}
