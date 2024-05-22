#pragma once

#define M 32
#define N 4

extern const double X[N * M];
extern const double Y[N * M];
extern const double G[N * M];

// volatile const int TEST_COUNT = 1;
volatile const int TEST_COUNT = N * M;

