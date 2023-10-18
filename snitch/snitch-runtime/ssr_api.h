#include <stdint.h>
#include <stddef.h>

/// The different SSR data movers.
enum snrt_ssr_dm {
    SNRT_SSR_DM0 = 0,
    SNRT_SSR_DM1 = 1,
    SNRT_SSR_DM2 = 2,
    // To write to all SSRs, use index 31
    SNRT_SSR_DM_ALL = 31,
};

/// The different dimensions.
enum snrt_ssr_dim {
    SNRT_SSR_1D = 0,
    SNRT_SSR_2D = 1,
    SNRT_SSR_3D = 2,
    SNRT_SSR_4D = 3,
};

/// The SSR configuration registers.
enum {
    REG_STATUS = 0,
    REG_REPEAT = 1,
    REG_BOUNDS = 2,   // + loop index
    REG_STRIDES = 6,  // + loop index
    REG_RPTR = 24,    // + snrt_ssr_dim
    REG_WPTR = 28,    // + snrt_ssr_dim
};

/// Synchronize the integer and float pipelines.
void snrt_fpu_fence(void);

/// Enable SSR.
void snrt_ssr_enable(void);

/// Disable SSR.
void snrt_ssr_disable(void);

// Configure an SSR data mover for a 1D loop nest.
void snrt_ssr_loop_1d(enum snrt_ssr_dm dm, size_t b0, size_t s0);

// Configure an SSR data mover for a 2D loop nest.
void snrt_ssr_loop_2d(enum snrt_ssr_dm dm, size_t b0, size_t b1,
                             size_t s0, size_t s1);

// Configure an SSR data mover for a 3D loop nest.
void snrt_ssr_loop_3d(enum snrt_ssr_dm dm, size_t b0, size_t b1,
                             size_t b2, size_t s0, size_t s1, size_t s2);

// Configure an SSR data mover for a 4D loop nest.
// b0: Inner-most bound (limit of loop)
// b3: Outer-most bound (limit of loop)
// s0: increment size of inner-most loop
void snrt_ssr_loop_4d(enum snrt_ssr_dm dm, size_t b0, size_t b1,
                             size_t b2, size_t b3, size_t s0, size_t s1,
                             size_t s2, size_t s3);

/// Configure the repetition count for a stream.
void snrt_ssr_repeat(enum snrt_ssr_dm dm, size_t count);

/// Start a streaming read.
void snrt_ssr_read(enum snrt_ssr_dm dm, enum snrt_ssr_dim dim,
                          volatile void *ptr);

/// Start a streaming write.
void snrt_ssr_write(enum snrt_ssr_dm dm, enum snrt_ssr_dim dim,
                           volatile void *ptr);
