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


function get_open_spiel() {

    OPEN_SPIEL_DIR="$PROJECT_ROOT/deps/open_spiel"

    [ -d $OPEN_SPIEL_DIR ] || git clone --depth 1 --branch v1.4 https://github.com/google-deepmind/open_spiel "$OPEN_SPIEL_DIR"
    (
        cd "$OPEN_SPIEL_DIR/open_spiel"
        [ -d build ] || mkdir build
    )

    docker run --rm \
        --user $(id -u):$(id -g) \
        --volume "$PROJECT_ROOT":/src \
        --workdir /src/deps/open_spiel \
        $BUILD_IMAGE \
        ./install.sh

    docker run --rm \
        --user $(id -u):$(id -g) \
        --volume "$PROJECT_ROOT":/src \
        --workdir /src/deps/open_spiel \
        $BUILD_IMAGE \
        open_spiel/scripts/build_and_run_tests.sh
}

function configure() {

    docker build -t $BUILD_IMAGE dev-image

    [ -d build ] || mkdir build
    [ -d deps ] || mkdir deps

    get_open_spiel



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
