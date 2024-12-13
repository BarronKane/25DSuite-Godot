@echo off
setlocal enableextensions
pushd "%~dp0"

CALL :GETPARENT PARENT
IF /I "%PARENT%" == "powershell" goto :ISPOWERSHELL
IF /I "%PARENT%" == "pwsh" goto :ISPOWERSHELL

if ERRORLEVEL 1 goto error 

goto :build 

:build 

git submodule update --init --recursive
pushd godot-cpp
scons platform=windows

goto :EOF 

:ISPOWERSHELL 

echo POWERSHELL DETECTED,
echo you may need to run this in CMD

goto :build 

:error 
echo UNKNOWN ERROR, do you have python and scons in your path?
pause
goto :EOF

:GETPARENT
SET "PSCMD=$ppid=$pid;while($i++ -lt 3 -and ($ppid=(Get-CimInstance Win32_Process -Filter ('ProcessID='+$ppid)).ParentProcessID)) {}; (Get-Process -EA Ignore -ID $ppid).Name"
for /f "tokens=*" %%i in ('powershell -noprofile -command "%PSCMD%"') do SET %1=%%i
goto :EOF
