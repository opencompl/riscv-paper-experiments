#include "data.h"

#include <snrt.h>

#include <stdint.h>

void fill(const double x, double* y) {
    for (uint32_t i = 0; i < M; ++i) {
        for (uint32_t j = 0; j < N; ++j) {
            // row-major accesses
            y[i * N + j] = x;
        }
    }
}
