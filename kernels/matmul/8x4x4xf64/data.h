#pragma once

#define M 8
#define K 4
#define N 4

extern const double X[M * K];
extern const double Y[K * N];
extern const double G_IN[M * N];
extern const double G_OUT[M * N];

// volatile const int TEST_COUNT = 1;
volatile const int TEST_COUNT = M * N;

