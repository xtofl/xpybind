#!/bin/bash

set -euxo pipefail

HERE=$(dirname "$0")
PROJECT_ROOT=$(realpath "$HERE/..")
cd "$PROJECT_ROOT"

if [  "x${XPYBIND_BUILD_IMAGE-}x" = "xx" ]; then
    BUILD_IMAGE=xpybind-build
else
    BUILD_IMAGE=$XPYBIND_BUILD_IMAGE
fi

function configure() {

    docker build -t $BUILD_IMAGE dev-image

    mkdir build

    docker run --rm \
        --user $(id -u):$(id -g) \
        --volume "$PROJECT_ROOT":/src \
        --workdir /src/build \
        $BUILD_IMAGE \
        cmake ..
}

function build() {
    docker run --rm \
        --user $(id -u):$(id -g) \
        --volume "$PROJECT_ROOT":/src \
        --workdir /src/build \
        $BUILD_IMAGE \
        cmake --build .

    [ -f build/xpybind.so ] || ln -s $(realpath build/*.so) build/xpybind.so
}

case "${1-}" in
    configure) configure ;;
    *) build ;;
esac
