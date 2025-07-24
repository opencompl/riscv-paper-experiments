#include "data.h"

#include <stdint.h>

// Baseline version, fused, unaliased ptrs allow for reduntant loads to
// be elided
// * Inputs:  x[ M x K ]
// * Weights: w[ K x N ]
// * Biases:  b[ M x N ]
// * Outputs: y[ M x N ]
void dense(const double* x, const double* w, const double* b, double* y) {
    // Y = relu(X W + B)
    for (uint32_t i = 0; i < M; ++i) {
        for (uint32_t j = 0; j < N; ++j) {
            double v = 0.0;
            for (uint32_t k = 0; k < K; ++k) {
                v += x[i * K + k] * w[k * N + j];
            }
            v += b[i * N + j];
            y[i * N + j] = v > 0. ? v : 0.;
        }
    }
}
