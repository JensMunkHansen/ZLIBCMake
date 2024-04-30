#!/bin/bash

rm -Rf $(pwd)/install
rm -Rf $(pwd)/build/library

(
    source "/home/jmh/github/emsdk/emsdk_env.sh"
    emcmake cmake -Bbuild/library -H./Library -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DCMAKE_BUILD_TYPE=Release
    cmake --build build/library --parallel 8
)
