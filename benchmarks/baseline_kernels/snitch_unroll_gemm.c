
void gemm_seq_baseline(unsigned int N, unsigned int M, unsigned int K, float* A,
                       unsigned int ldA, float* B, unsigned int ldB,
                       float* C, unsigned int ldC) {
    // We are restricted to two as we unrolled
    // the loop manually.
    const unsigned int tf = 2;

    for (unsigned int n1 = 0; n1 < N; n1 += tf) {
        for (unsigned int m1 = 0; m1 < M; m1 += tf) {
            for (unsigned int k1 = 0; k1 < K; k1 += tf) {
                for (unsigned int n2 = 0; n2 < tf; n2++) {
                    for (unsigned int m2 = 0; m2 < tf; m2++) {
                        float c = C[(n1+n2)*ldC+(m1+m2)];
                        for (unsigned int k2 = 0; k2 < tf; k2++) {
                            c += A[(n1+n2)*ldA+(k1+k2)] *
                            B[(k1+k2)*ldB+(m1+m2)]; 
                        }
                        C[(n1+n2)*ldC+(m1+m2)] = c;
                    }
                }
            }
        }
    }
}
