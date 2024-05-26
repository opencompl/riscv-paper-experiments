#pragma once

#define N 1
#define C 1
#define H 14
#define W 18
#define F 1
#define NEW_H 12
#define NEW_W 16

extern const double X[N * C * H * W];
extern const double Y[F * C * 3 * 3];
extern const double Z_IN[N * F * NEW_H * NEW_W];
extern const double Z_OUT[N * F * NEW_H * NEW_W];

// volatile const int TEST_COUNT = 1;
volatile const int TEST_COUNT = N * F * NEW_H * NEW_W;

