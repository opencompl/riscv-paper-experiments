.DEFAULT_GOAL := all

include ../../../snitch/Makefile.rules

PRES =
PRES += pres_0_llvm.x
PRES += pres_1_llvm_clean.x
PRES += pres_2_ssr_loop.x
PRES += pres_3_ssr_frep.x

TESTS = $(PRES)
TESTS += baseline.x
TESTS += noalias.x
TESTS += ssr1d.x
TESTS += ssr1d_frep1d.x
TESTS += ssr2d.x
TESTS += linalg.x
TESTS += vector.x
TESTS += scf.x
TESTS += linalg_2.x

include ../../Makefile.kernels

# Presentation specific

all-pres: $(PRES)

allrun-pres: TESTS=$(PRES)
allrun-pres: $(RUN)
