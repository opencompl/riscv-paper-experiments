#include "data_13x26xf32.h"

#include <stdint.h>

void addf(float* A, const float* B) {
    for (int32_t i = 0; i < M; ++i) {
        for (int32_t j = 0; j < N; ++j) {
            A[i * N + j] += B[i * N + j];
        }
    }
}
