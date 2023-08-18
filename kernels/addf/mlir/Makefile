include ../../../snitch/Makefile.rules

# Defaults for snitch-toolchain docker image:
OPT                   ?= mlir-opt-16
TRANSLATE             ?= mlir-translate-16
SPIKE                 ?= /opt/snitch-spike/bin/spike-dasm
SIMULATOR             ?= /opt/snitch-rtl/bin/snitch_cluster.vlt
SNITCH_RUNTIME_PREFIX ?= /opt/snitch-runtime
MLIR_RUNTIME_PREFIX   ?= $(SNITCH_RUNTIME_PREFIX)

OPTFLAGS =
OPTFLAGS += -opaque-pointers=0
OPTFLAGS += --convert-linalg-to-loops
OPTFLAGS += --convert-scf-to-cf
OPTFLAGS += --canonicalize
OPTFLAGS += --cse
OPTFLAGS += --convert-math-to-llvm
OPTFLAGS += --convert-memref-to-llvm='use-generic-functions index-bitwidth=32'
OPTFLAGS += --convert-func-to-llvm='use-bare-ptr-memref-call-conv index-bitwidth=32'
OPTFLAGS += --convert-index-to-llvm=index-bitwidth=32
OPTFLAGS += --convert-cf-to-llvm=index-bitwidth=32
OPTFLAGS += --convert-arith-to-llvm=index-bitwidth=32
OPTFLAGS += --reconcile-unrealized-casts

OBJS =
OBJS += addf.o
OBJS += data.o
OBJS += memref_diff.o
OBJS += main_snitch.o

.PRECIOUS: %.s %.ll.mlir

main_snitch.x: $(OBJS)
	$(LD) $(LDFLAGS) $(SNITCH_RUNTIME_PREFIX)/lib/libsnitch-runtime.a $(MLIR_RUNTIME_PREFIX)/lib/libmlir-runtime.a $^ -o $@

%.ll.mlir: %.mlir
	$(OPT) $(OPTFLAGS) -o $@ $<

%.ll: %.ll.mlir
	$(TRANSLATE) -opaque-pointers=0 --mlir-to-llvmir -o $@ $<

run: main_snitch.x
	$(SIMULATOR) $<

logs/trace_hart_%.txt: logs/trace_hart_%.dasm
	$(SPIKE) < $< | ../../../snitch/gentrace.py > $@

traces: $(shell (ls logs/trace_hart_*.dasm 2>/dev/null | sed 's/\.dasm/\.txt/') || echo "")

clean:
	rm -fr *.o *.a *.ll12 addf.x logs/
