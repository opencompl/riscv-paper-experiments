include ../../../snitch/Makefile.rules

# Defaults for snitch-toolchain docker image:
SPIKE                 ?= /opt/snitch-spike/bin/spike-dasm
SIMULATOR             ?= /opt/snitch-rtl/bin/snitch_cluster.vlt
SNITCH_RUNTIME_PREFIX ?= /opt/snitch-runtime

OBJS =
OBJS += addf.o
OBJS += data.o
OBJS += diff.o
OBJS += main_snitch.o

CFLAGS += -Wall -Wextra -pedantic
CFLAGS += -I$(SNITCH_RUNTIME_PREFIX)/include

main_snitch.x: $(OBJS)
	$(LD) $(LDFLAGS) $(SNITCH_RUNTIME_PREFIX)/lib/libsnitch-runtime.a $^ -o $@

run: main_snitch.x
	$(SIMULATOR) $<

logs/trace_hart_%.txt: logs/trace_hart_%.dasm
	$(SPIKE) < $< | ../../../snitch/gentrace.py > $@

traces: $(shell (ls logs/trace_hart_*.dasm 2>/dev/null | sed 's/\.dasm/\.txt/') || echo "")

clean:
	rm -fr *.o *.a main_snitch.x logs/
