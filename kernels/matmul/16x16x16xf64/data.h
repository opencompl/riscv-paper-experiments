#pragma once

#define M 16
#define K 16
#define N 16

extern const double X[M * K];
extern const double Y[K * N];
extern const double G_IN[M * N];
extern const double G_OUT[M * N];

#define TEST_COUNT (M * N)

