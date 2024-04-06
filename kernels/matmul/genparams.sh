#!/bin/bash

# Check if three parameters are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <M> <K> <N>"
    exit 1
fi

# Assign parameters to variables
M="$1"
K="$2"
N="$3"

# Generate JSON
cat <<EOF
{
    "M": $M,
    "K": $K,
    "N": $N,
    "rmin": -1000.0,
    "rmax": 1000.0,
    "precision": 64
}
EOF
