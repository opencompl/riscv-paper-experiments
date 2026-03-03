from enum import StrEnum


class Impl(StrEnum):
    OURS = "Ours"
    CLANG = "Clang"
    MLIR = "MLIR"


class Operator(StrEnum):
    EXP = "Exp"
