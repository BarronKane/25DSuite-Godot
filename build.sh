#!/bin/bash

set -e

cd "`dirname "$0"`"

git submodule update --init --recursive
pushd emsdk
emsdk install latest
emsdk activate latest
emsdk_env.sh
popd
pushd godot-cpp
scons platform=linux
popd
scons platform=windows
