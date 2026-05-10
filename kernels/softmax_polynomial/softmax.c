#include "data.h"

#ifdef __cplusplus
extern "C" {
#endif

// Element-wise exp; provided by the MLIR/xDSL pipeline (linalg.mlir.template
// produces this symbol after xDSL lowering passes).
extern void exp_kernel(const DTYPE *x, DTYPE *z);

#if PRECISION == 16
// snitch-llvm -mno-fdiv only emulates fdiv.s/.d; fdiv.h still traps
// (DIVSQRT disabled on this cluster). -ffast-math also folds
// (_Float16)(1.0f / (float)s) back into a single fdiv.h, so we need an
// opaque call the optimizer can't see through. __divsf3 is provided by
// clang_rt.builtins-riscv32 (linked via ldflags).
extern float __divsf3(float, float);
#endif

// Step 1: max over x[0..N).
static DTYPE softmax_max(const DTYPE *x) {
    DTYPE m = x[0];
    for (int i = 1; i < N; i++) {
        if (x[i] > m) m = x[i];
    }
    return m;
}

// Step 2: e[i] = exp(x[i] - m); returns sum(e).
// Subtraction is done in C, the elementwise exp goes through the extern
// kernel so xDSL can lower it. exp_kernel(e, e) is safe because each
// output element only depends on the corresponding input element.
static DTYPE softmax_exp_sum(const DTYPE *x, DTYPE m, DTYPE *e) {
    for (int i = 0; i < N; i++) {
        e[i] = x[i] - m;
    }
    exp_kernel(e, e);
    DTYPE s = (DTYPE)0;
    for (int i = 0; i < N; i++) {
        s += e[i];
    }
    return s;
}

// Step 3: e[i] /= sum.
static void softmax_normalize(DTYPE *e, DTYPE inv_sum) {
    for (int i = 0; i < N; i++) {
        e[i] *= inv_sum;
    }
}

void softmax_kernel(const DTYPE *x, DTYPE *z) {
    DTYPE m = softmax_max(x);
    DTYPE s = softmax_exp_sum(x, m, z);
#if PRECISION == 16
    DTYPE inv_s = (DTYPE)__divsf3(1.0f, (float)s);
#else
    DTYPE inv_s = (DTYPE)1.0 / s; // fdiv is emulated only once
#endif
    softmax_normalize(z, inv_s);
}

#ifdef __cplusplus
}
#endif
