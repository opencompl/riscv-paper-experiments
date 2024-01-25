#include "data.h"

#include <snrt.h>

#include <stdint.h>

void matmul(const double* restrict x, const double* restrict y, double* restrict g) {
    for (uint32_t i = 0; i < M; ++i) {
        for (uint32_t j = 0; j < N; ++j) {
            for (uint32_t k = 0; k < K; ++k) {
                // row-major accesses
                g[i * N + j] += x[i * K + k] * y[k * N + j];
            }
        }
    }
}
