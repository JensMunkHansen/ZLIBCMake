@echo off
rmdir /Q /S build\usage

cmake -Bbuild/usage -H./Usage -DCMAKE_PREFIX_PATH="%~dp0install"
cmake --build build/usage --parallel 8
