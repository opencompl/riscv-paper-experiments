.DEFAULT_GOAL := all

include ../../../snitch/Makefile.rules

TESTS =
TESTS += baseline.x
TESTS += noalias.x
TESTS += ssr.x
TESTS += ssr_frep.x
TESTS += ssr_frep_unroll.x
TESTS += linalg.x

include ../../Makefile.kernels

%.o: ../%.c
	$(CC) $(CFLAGS) -I$(dir $(abspath $@)) -c $< -o $@
