#pragma once

#define M 4
#define K 32
#define N 32

#define PRECISION 32

#if PRECISION == 64
#define TYPE double
#elif PRECISION == 32
#define TYPE float
#else
#error precision not yet supported
#endif

extern const TYPE X[M * K];
extern const TYPE Y[K * N];
extern const TYPE G_IN[M * N];
extern const TYPE G_OUT[M * N];

