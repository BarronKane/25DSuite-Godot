$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Push-Location $dir

git submodule update --init --recursive
Push-Location emsdk
./emsdk install latest
./emsdk activate latest
./emsdk_env.ps1
Pop-Location
Push-Location godot-cpp
scons platform=windows
scons platform=web
Pop-Location
scons platform=windows
scons platform=web
