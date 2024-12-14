#!/bin/bash
set -e
cd "`dirname "$0"`"

build_system=""
build_arch=""

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     
        echo "LINUX"
        build_system=Linux
        ;;
    Darwin*)   
        echo "APPLE"
        build_system=macos
        ;;
    CYGWIN*)    
        echo "CYGWIN-WINDOWS"
        build_system=windows
        ;;
    MINGW*)     
        echo "MINGW-WINDOWS"
        build_system=windows
        ;;
    MSYS_NT*)   
        echo "MSYS_NT-WINDOWS"
        build_system=windows
        ;;
    *)          
    echo "UNKNOWN MACHINE, YOU MAY NEED TO BUILD MANUALLY"
esac

if [ $build_system == "windows" ]
then
    echo "Windows detected, please use the .bat or .ps1 file."
    return 1 2>/dev/null
fi

arch="$(uname -m)"
if [[ "$arch" = x86_64* ]]; then
    if [[ "$(uname -a)" = *ARM64* ]]; then
        echo "Building for Apple Silicon"
        build_arch="arm64"
    else
        build_arch="x86_64"
    fi
fi

git submodule update --init --recursive
pushd emsdk
./emsdk install latest
./emsdk activate latest
./emsdk_env.sh
popd

count=`ls -1 ./godot-cpp/bin/*.lib 2>/dev/null | wc -l`
if [ $count == 0 ]
then
    echo "Building GODOT-CPP"
    pushd godot-cpp
    scons platform=$build_system arch=$build_arch
    scons platform=web
    popd
fi
scons platform=$build_system arch=$build_arch
scons platform=web


