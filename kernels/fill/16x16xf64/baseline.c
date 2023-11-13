#include "data.h"

#include <snrt.h>

#include <stdint.h>

void fill(const double x, double* y) {
    for (uint32_t i = 0; i < M * N; ++i) {
        // row-major accesses
        y[i] = x;
    }
}
