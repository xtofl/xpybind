# xpybind

Experiments with pybind11: some demo C++ code that can be called seamlessly
from python.

Build result is a C++ package; with this package on the Python module
search path, `import xpybind` will expose its functions in Python.

## TODO

* BUG: only runs with python3.8 when built with the build scripts.
* BUG: the build output is not picked up by Python (hence a symlink in the build.sh:build function)
* FEATURE: export a slightly more complex function
* FEATURE: export a function from third-party library (e.g. open-spiel)

## Features

### Build Image

A Docker image to build the library with.

### Build Script

Usage: 

1. `scripts/build.sh configure` will create a build dir and run CMake from it.
2. `scripts/build.sh` will subsequently build it
3. `scripts/test.sh` will subsequently test its python integration

### Simple Function

A very simple function `xpybind.simple_function(int, int)` that can be called from Python.

