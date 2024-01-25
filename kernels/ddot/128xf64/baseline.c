#include "data.h"

#include <stdint.h>

void ddot(const double* restrict x, const double* restrict y, double* restrict g) {
    double acc = *g;
    for (uint32_t i = 0; i < N; ++i) {
        acc += x[i] * y[i];
    }
    *g = acc;
}
