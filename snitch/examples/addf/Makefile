include ../../Makefile.rules

SNITCH_RUNTIME_PREFIX ?= /opt/snitch-runtime
MLIR_RUNTIME_PREFIX ?= $(SNITCH_RUNTIME_PREFIX)

OBJS =
OBJS += addf.o
OBJS += main.o

CFLAGS += -I$(SNITCH_RUNTIME_PREFIX)/include
CFLAGS += -Wall -Wextra -pedantic

addf.x: $(OBJS)
	$(LD) $(LDFLAGS) $(SNITCH_RUNTIME_PREFIX)/lib/libsnitch-runtime.a $(MLIR_RUNTIME_PREFIX)/lib/libmlir-runtime.a $^ -o $@

run: addf.x
	/opt/snitch-rtl/bin/snitch_cluster.vlt $<

logs/trace_hart_%.txt: logs/trace_hart_%.dasm ../../gentrace.py
	/opt/snitch-spike/bin/spike-dasm < $< | ../../gentrace.py > $@

traces: $(shell (ls logs/trace_hart_*.dasm 2>/dev/null | sed 's/\.dasm/\.txt/') || echo "")

clean:
	rm -fr *.o *.a *.ll12 addf.x logs/
