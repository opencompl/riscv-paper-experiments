#include "data.h"

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void ddot(const double* x, const double* y, double* g) {
    double acc = *g;
    for (uint32_t i = 0; i < N; ++i) {
        acc += x[i] * y[i];
    }
    *g = acc;
}

#ifdef __cplusplus
}
#endif
