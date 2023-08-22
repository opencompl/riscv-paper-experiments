TESTS =
TESTS += addf_13x26xf32_clang.x
TESTS += addf_13x26xf32_clang_noalias.x
TESTS += addf_13x26xf32_mliropt.x

include ../../../snitch/Makefile.rules
include ../../Makefile.mlir.rules

# Defaults for snitch-toolchain docker image:
SPIKE                 ?= /opt/snitch-spike/bin/spike-dasm
SIMULATOR             ?= /opt/snitch-rtl/bin/snitch_cluster.vlt
SNITCH_RUNTIME_PREFIX ?= /opt/snitch-runtime

OBJS =
OBJS += data_13x26xf32.o
OBJS += testcase.addf_13x26xf32.o
OBJS += testcase.snitch.o
OBJS += main.o

CFLAGS += -std=gnu11
CFLAGS += -Wall -Wextra -pedantic
CFLAGS += -I$(SNITCH_RUNTIME_PREFIX)/include

all: $(TESTS)

%.x: %.o $(OBJS)
	$(LD) $(LDFLAGS) $(SNITCH_RUNTIME_PREFIX)/lib/libsnitch-runtime.a $^ -o $@

RUNTESTS = $(addprefix run_, $(TESTS))
$(RUNTESTS): run_%: %
	$(SIMULATOR) $<

run: $(RUNTESTS)

logs/trace_hart_%.txt: logs/trace_hart_%.dasm
	$(SPIKE) < $< | ../../../snitch/gentrace.py > $@

traces: $(shell (ls logs/trace_hart_*.dasm 2>/dev/null | sed 's/\.dasm/\.txt/') || echo "")

clean:
	rm -fr *.o *.a *.x logs/
