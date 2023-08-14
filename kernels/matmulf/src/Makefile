CLANG     = clang
OPT       = mlir-opt
TRANSLATE = mlir-translate

CFLAGS =
CFLAGS += -O3

LDFLAGS =
# When linking for macOS with a non-apple clang:
LDFLAGS += -Wl,-syslibroot,/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk

OPTFLAGS =
OPTFLAGS += -opaque-pointers=0
OPTFLAGS += --convert-linalg-to-loops
OPTFLAGS += --convert-scf-to-cf
OPTFLAGS += --canonicalize
OPTFLAGS += --cse
OPTFLAGS += --convert-math-to-llvm
OPTFLAGS += --convert-memref-to-llvm
# OPTFLAGS += --convert-memref-to-llvm='use-generic-functions index-bitwidth=32'
# OPTFLAGS += --convert-func-to-llvm='use-bare-ptr-memref-call-conv index-bitwidth=32'
OPTFLAGS += --convert-func-to-llvm=
OPTFLAGS += --convert-index-to-llvm
OPTFLAGS += --convert-cf-to-llvm
OPTFLAGS += --convert-arith-to-llvm
OPTFLAGS += --reconcile-unrealized-casts

.PRECIOUS: %.s %.ll.mlir

%.ll.mlir: %.mlir
	$(OPT) $(OPTFLAGS) -o $@ $<

%.ll: %.ll.mlir
	$(TRANSLATE) -opaque-pointers=0 --mlir-to-llvmir -o $@ $<

%.S: %.ll
	$(CLANG) $(CFLAGS) -c -S -masm=intel -o $@ $<

main_2_2_2.x: main_2_2_2.S matmulf_2_2_2.S data_2_2_2.S diff.S
	$(CLANG) $(LDFLAGS) -o $@ $^

main_4_4_4.x: main_4_4_4.S matmulf_4_4_4.S data_4_4_4.S diff.S
	$(CLANG) $(LDFLAGS) -o $@ $^

clean:
	@rm -f *.ll.mlir *.ll *.S *.x
