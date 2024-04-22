@echo off
rmdir /Q /S install
rmdir /Q /S build\library

if [%1]==[] goto usage

set myArg=%1

REM Both shared and static are build
if %myArg% == shared (
  echo SHARED
  cmake -B build/library -H%~dp0/Library -DCMAKE_INSTALL_PREFIX=%~dp0/install
) else (
  echo STATIC
  cmake -B build/library -H%~dp0/Library -DCMAKE_INSTALL_PREFIX=%~dp0/install
)

cmake --build build/library  --config Release --parallel 20 -- -maxCpuCount:20
REM cmake --build build/library  --config Debug --parallel 20 -- -maxCpuCount:20

:usage
@echo Usage: %0 static/shared
