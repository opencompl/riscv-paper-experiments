#!/usr/bin/env python3

import json
from pathlib import Path
import numpy as np
import argparse
import sys
import abc

from typing import Callable, Iterator, Literal, NamedTuple, ParamSpec


class Define(NamedTuple):
    name: str
    value: int


class Array(NamedTuple):
    name: str
    shape_names: tuple[str]
    data: np.ndarray


def array_precision(array: Array) -> int:
    return {
        np.dtype("float32"): 32,
        np.dtype("float64"): 64,
    }[array.data.dtype]


def array_to_memref_initializer(array: np.array):
    return ",\n".join(f"  {np.array2string(row, separator=', ')}" for row in array)


def array_to_c_initializer(array: np.array):
    return np.array2string(array.flatten(), separator=",\n").strip(" []")


class Printer(abc.ABC):

    BASE_PRINTOPTIONS = {"linewidth": None, "threshold": sys.maxsize}
    C_PRINTOPTIONS = {
        **BASE_PRINTOPTIONS,
        "formatter": {"double ": lambda x: f"{x:+}f"},
    }
    MLIR_PRINTOPTIONS = {**BASE_PRINTOPTIONS, "sign": "+"}

    def __init__(self):
        np.set_printoptions(**self.np_printoptions())

    @classmethod
    @abc.abstractmethod
    def np_printoptions(cls): ...

    @classmethod
    @abc.abstractmethod
    def fmt(cls, array: np.array, *, precision: int, shape=None, symbol=None): ...

    def print_define(self, define: Define):
        print(f"#define {define.name} {define.value}")

    def print_array(self, array: Array):
        shape = " * ".join(array.shape_names)
        print(
            self.fmt(
                array.data,
                shape=shape,
                precision=array_precision(array),
                symbol=array.name,
            )
        )

    def print(self, item: Define | Array):
        match item:
            case Define():
                self.print_define(item)
            case Array():
                self.print_array(item)

    def print_items(self, items: Iterator[Define | Array]):
        for item in items:
            self.print(item)


class CPrinter(Printer):

    @classmethod
    def np_printoptions(cls):
        return Printer.C_PRINTOPTIONS

    @classmethod
    def fmt(cls, array: np.array, *, precision: int, shape=None, symbol=None):
        return ARRAY_GLOBAL.format(
            symbol=symbol or "array",
            type=C_TYPES[str(precision)],
            shape=shape or "*".join(str(dim) for dim in array.shape),
            initializer=array_to_c_initializer(array),
        )


class MLIRPrinter(Printer):

    @classmethod
    def np_printoptions(cls):
        return Printer.MLIR_PRINTOPTIONS

    @classmethod
    def fmt(cls, array: np.array, precision: int, shape=None, symbol=None):
        return MEMREF_GLOBAL.format(
            symbol=symbol or "array",
            type=MLIR_TYPES[str(precision)],
            shape=shape or "x".join(str(dim) for dim in array.shape),
            initializer=array_to_memref_initializer(array),
        )


def get_printer(format: Literal["c", "mlir"]):
    return {
        "c": CPrinter,
        "mlir": MLIRPrinter,
    }[format]()


C_TYPES = {
    "32": "float",
    "64": "double",
}

NUMPY_TYPES = {
    "32": np.single,
    "64": np.double,
}

MLIR_TYPES = {
    "32": "f32",
    "64": "f64",
}

MEMREF_GLOBAL = """
memref.global constant @{symbol} : memref<{shape}x{type}> = dense<[
{initializer}
]>
"""


ARRAY_GLOBAL = """
const {type} {symbol}[{shape}] = {{
{initializer}
}};
"""

_P = ParamSpec("_P")


def main(items_iterator_factory: Callable[_P, Iterator[Define | Array]]) -> None:
    parser = argparse.ArgumentParser(
        prog="gendata.py",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-p",
        "--params",
        type=Path,
        required=True,
        help="parameters for data generation",
    )
    parser.add_argument(
        "--format", default="c", choices=["mlir", "c"], help="output format"
    )
    args = parser.parse_args()

    with open(args.params, "r") as f:
        params = json.load(f)

    printer = get_printer(args.format)
    printer.print_items(items_iterator_factory(**params))
