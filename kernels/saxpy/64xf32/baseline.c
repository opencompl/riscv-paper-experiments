#include "data.h"

#include <snrt.h>

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void saxpy(float a, const float* x, const float* y, float* z) {
    const uint32_t n = N;
    for (uint32_t i = 0; i < n; ++i) {
        z[i] = a * x[i] + y[i];
    }
}

#ifdef __cplusplus
}
#endif
