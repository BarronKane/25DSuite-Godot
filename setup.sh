#!/bin/bash

set -e

cd "`dirname "$0"`"

git submodule update --init --recursive
pushd godot-cpp
scons platform=linux
popd
scons platform=windows
