#!/bin/bash

set -euxo pipefail

HERE=$(dirname "$0")
PROJECT_ROOT=$(realpath "$HERE/..")
cd "$PROJECT_ROOT"

PYTHON_VERSION=${PYTHON_VERSION-3.8}

(
    export PYTHONPATH=$(realpath build)

    python -c 'import xpybind; print(xpybind.simple_method(1, 2))'
)

