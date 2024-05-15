#include "data.h"

#include <snrt.h>

#include <stdint.h>

// Copied from math.h
double fmax(double __x, double __y) { return __builtin_fmax(__x, __y); }

void relu(const double* restrict x, double* restrict y) {
    for (uint32_t i = 0; i < M; ++i) {
        for (uint32_t j = 0; j < N; ++j) {
            // row-major accesses
            y[i * N + j] = fmax(0.0, x[i * N + j]);
        }
    }
}
