#!/bin/bash

rm -Rf $(pwd)/install
rm -Rf $(pwd)/build/library

# cmake -Bbuild/library -H./Library -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=$EMSDK/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake

emcmake cmake -Bbuild/library -H./Library -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DCMAKE_BUILD_TYPE=Release

cmake --build build/library --parallel 8
