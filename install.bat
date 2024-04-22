@echo off
rmdir /Q /S install
rmdir /Q /S build\library


cmake -B build/library -H%~dp0/Library -DCMAKE_INSTALL_PREFIX=%~dp0/install 
cmake --build build/library  --config Release --parallel 8

REM cmake -Bbuild/library -HLibrary -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DCMAKE_BUILD_TYPE=Release
REM cmake --build build/library --parallel 8 --target install
