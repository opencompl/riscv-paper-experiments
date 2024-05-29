#pragma once

#define N 1
#define C 1
#define H 18
#define W 14
#define F 1
#define NEW_H 16
#define NEW_W 12

extern const double X[N * C * H * W];
extern const double Y[F * C * 3 * 3];
extern const double Z_IN[N * F * NEW_H * NEW_W];
extern const double Z_OUT[N * F * NEW_H * NEW_W];

#define TEST_COUNT (N * F * NEW_H * NEW_W)

