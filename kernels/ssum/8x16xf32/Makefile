.DEFAULT_GOAL := all

include ../../../snitch/Makefile.rules

TESTS =
TESTS += baseline.x
TESTS += noalias.x
TESTS += ssr1d.x
TESTS += ssr1d_frep1d.x
TESTS += ssr2d.x
TESTS += linalg.x
TESTS += vector.x
TESTS += scf.x

include ../../Makefile.kernels

# Presentation specific

all-pres: $(PRES)

allrun-pres: TESTS=$(PRES)
allrun-pres: $(RUN)
