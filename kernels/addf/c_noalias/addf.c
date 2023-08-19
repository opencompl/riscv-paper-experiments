#include "addf.h"
#include "data.h"

#include <stdint.h>

void addf(float* restrict A, const float* restrict B) {
    for (int32_t i = 0; i < M; ++i) {
        for (int32_t j = 0; j < N; ++j) {
            A[i * N + j] += B[i * N + j];
        }
    }
}
