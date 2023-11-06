#include "data.h"

#include <stdint.h>

// Baseline version, non-fused, unaliased ptrs allow for reduntant loads to be elided
// Inputs:  x[ M x K ]
// Weights: w[ K x N ]
// Biases:  b[ M x N ]
// Outputs: y[ M x N ]
void dense(const double* restrict x, const double* restrict w, const double* restrict b,
           double* restrict y) {
    // Y = X W
    for (uint32_t i = 0; i < M; ++i) {
        for (uint32_t j = 0; j < N; ++j) {
            for (uint32_t k = 0; k < K; ++k) {
                y[i * N + j] += x[i * K + k] * w[k * N + j];
            }
        }
    }

    // Y = Y + B
    for (uint32_t i = 0; i < M; ++i) {
        for (uint32_t j = 0; j < N; ++j) {
            y[i * N + j] += b[i * N + j];
        }
    }

    // Y = relu(Y)
    for (uint32_t i = 0; i < M; ++i) {
        for (uint32_t j = 0; j < N; ++j) {
            double v = y[i * N + j];
            y[i * N + j] = v > 0. ? v : 0.;
        }
    }
}
