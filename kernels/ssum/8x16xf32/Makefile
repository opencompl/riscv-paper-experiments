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

clean:
	rm -fr *.ll12 *.x *.o *.logs/ logs/
