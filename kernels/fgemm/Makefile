SIZES = 2
SIZES += 4
SIZES += 6
SIZES += 8
SIZES += 10
SIZES += 12
SIZES += 14
SIZES += 16
SIZES += 18
SIZES += 20

define define-main-target
src/main_$1_$1_$1.mlir: main.template.mlir
	./gensource.py -m $1 -n $1 -k $1 < main.template.mlir > src/main_$1_$1_$1.mlir
all:: src/main_$1_$1_$1.mlir
endef

define define-matmulf-target
src/matmulf_$1_$1_$1.mlir: matmulf.template.mlir
	./gensource.py -m $1 -n $1 -k $1 < matmulf.template.mlir > src/matmulf_$1_$1_$1.mlir
all:: src/matmulf_$1_$1_$1.mlir
endef

define define-data-target
src/data_$1_$1_$1.mlir:
	./gendata.py -m $1 -n $1 -k $1 > src/data_$1_$1_$1.mlir
all:: src/data_$1_$1_$1.mlir
endef

$(foreach element,$(SIZES),$(eval $(call define-main-target,$(element))))
$(foreach element,$(SIZES),$(eval $(call define-matmulf-target,$(element))))
$(foreach element,$(SIZES),$(eval $(call define-data-target,$(element))))