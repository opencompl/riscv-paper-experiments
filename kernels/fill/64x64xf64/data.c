#define M 64
#define N 64

const double X = 4.0;


const double Y[M * N] = {
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
 4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.,
4.
};

