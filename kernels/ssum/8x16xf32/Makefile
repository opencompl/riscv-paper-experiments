.DEFAULT_GOAL := all

include ../../../snitch/Makefile.rules

PRES =
PRES += pres_0_llvm.x
PRES += pres_1_llvm_clean.x
PRES += pres_2_vectorized.x
PRES += pres_3_ssr_loop.x
PRES += pres_4_ssr_unrolled.x

TESTS = $(PRES)
TESTS += baseline.x
TESTS += noalias.x
TESTS += ssr1d.x
TESTS += ssr1d_frep1d.x
TESTS += ssr2d.x
TESTS += linalg.x
TESTS += vector.x
TESTS += scf.x

CFLAGS += -std=gnu11
CFLAGS += -Wall -Wextra

%.x: %.o main.o data.o
	$(LD) $(LDFLAGS) $^ -o $@

sim_%: %
	rm -fr ./logs/
	$(VLTSIM) $<

RUN = $(addprefix run_, $(TESTS))
$(RUN): run_%: sim_%
	mv logs $(subst sim_,,$<).logs

all: $(TESTS)

allrun: $(RUN)


RUN_PRES = $(addprefix run_, $(PRES))
$(RUN_PRES): run_%: sim_%
	mv logs $(subst sim_,,$<).logs

all-pres: $(PRES)

allrun-pres: $(RUN_PRES)

clean:
	rm -fr *.ll12 *.x *.o *.logs/ logs/
