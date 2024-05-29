#include "data.h"

#include <snrt.h>

#include <stdint.h>

void dsum(const double* restrict x, const double* restrict y, double* restrict z) {
    for (uint32_t i = 0; i < N * M; ++i) {
        z[i] = x[i] + y[i];
    }
}

