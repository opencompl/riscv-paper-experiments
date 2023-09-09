#include "data.h"

#include <snrt.h>

#include <stdint.h>

void ssum(const float* x, const float* y, float* z) {
    for (uint32_t i = 0; i < N * M; ++i) {
        z[i] = x[i] + y[i];
    }
}
