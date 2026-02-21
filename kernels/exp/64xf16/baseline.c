#include "data.h"

#include <snrt.h>

#include <math.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void exp_kernel(const fp_t* x, fp_t* z) {
    const uint32_t n = N;
    for (uint32_t i = 0; i < n; ++i) {
        z[i] = EXPF(x[i]);
    }
}

#ifdef __cplusplus
}
#endif
