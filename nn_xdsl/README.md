# Getting RISC-V Binary From a Neural Network

## Installation

``` sh
source venv/bin/activate
pip install --upgrade pip

# Install xDSL + dependencies
cd xdsl
pip install -e ".[extras]" --require-venv
cd ..

# Install stardew + dependencies
cd stardew
pip install -r requirements.txt --require-venv
pip install . --require-venv
cd ..

# Install dependencies of this project
pip install -r requirements.txt --require-venv
```
