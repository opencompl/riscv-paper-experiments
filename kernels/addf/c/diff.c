#include "diff.h"

#include "data.h"

#include <math.h>
#include <stdint.h>

uint32_t diff(const float* A, const float* B, float eps) {
    uint32_t ndiff = 0;
    for (int32_t i = 0; i < M; ++i) {
        for (int32_t j = 0; j < N; ++j) {
            float d = fabs(A[i * N + j] - B[i * N + j]);
            if (d > eps) ++ndiff;
        }
    }
    return ndiff;
}
