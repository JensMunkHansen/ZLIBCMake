@echo off
rmdir /Q /S build\usage

if [%1]==[] goto usage

set myArg=%1

if %myArg% == shared (
  echo SHARED
  cmake -Bbuild/usage -H./Usage -DCMAKE_PREFIX_PATH="%~dp0install" -DBUILD_SHARED_LIBS=ON
) else (
  echo STATIC
  cmake -Bbuild/usage -H./Usage -DCMAKE_PREFIX_PATH="%~dp0install"
)

cmake --build build/usage --config Release --parallel 20 -- -maxCpuCount:20
cmake --build build/usage --config Debug --parallel 20 -- -maxCpuCount:20

build\usage\Release\main.exe
build\usage\Debug\main.exe
goto :eof

:usage
@echo Usage: %0 static/shared
