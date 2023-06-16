#define NI 4
#define KERNEL_SIZE NI*NI

int main(void)
{
  int A[KERNEL_SIZE] = {7, 85, 14, 3, 0, 1, 2, 20, 7, 4, 3, 18, 26, 75, 94, 47};
  int B[KERNEL_SIZE] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
  int result[KERNEL_SIZE];

  int i = 0;
  int j;
  int k;
  int sum;
  int r = 0;

  for (i = 0; i < NI; i++) {
    for (j = 0; j < NI; j++) {
      sum = 0;
      for (k = 0; k < NI; k++)
        sum += A[(i << 2) + k] * B[(k << 2) + j];
      result[(i << 2) + j] = sum;
    }

    r += result[i];
  }


  // prevent compiler from optimizing out the loop
  return r;
}

