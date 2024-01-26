#include "data.h"

#include <snrt.h>

#include <stdint.h>

#if 0
// Copied from math.h
double exp(double __x) { return __builtin_exp(__x); }
#else
double exp(double x) {
    int terms = 75;
    double result = 1.0;
    double term = 1.0;
    int i;

    for (i = 1; i < terms; ++i) {
        term *= x / i;
        result += term;
    }

    return result;
}
#endif

// Copied from math.h
double fmax(double __x, double __y) { return __builtin_fmax(__x, __y); }

void softmax(const double* restrict x, double* restrict y) {
    double sum = 0.0;
    double maxval = x[0];

    for (uint32_t i = 0; i < N; ++i) {
        maxval = fmax(maxval, x[i]);
    }
    for (uint32_t i = 0; i < N; ++i) {
        y[i] = exp(x[i] - maxval);
        sum += y[i];
    }
    for (uint32_t i = 0; i < N; ++i) {
        y[i] /= sum;
    }
}
