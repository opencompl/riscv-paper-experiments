#include "data.h"

#include <stdint.h>

void ddot(const double* x, const double* y, double* g) {
    double acc = *g;
    for (uint32_t i = 0; i < N; ++i) {
        acc += x[i] * y[i];
    }
    *g = acc;
}
