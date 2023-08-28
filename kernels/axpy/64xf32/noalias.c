#include "data.h"

#include <snrt.h>

#include <stdint.h>

void axpy(float a, const float* restrict x, const float* restrict y, float* restrict z) {
    const uint32_t n = N;
    for (uint32_t i = 0; i < n; ++i) {
        z[i] = a * x[i] + y[i];
    }
}
