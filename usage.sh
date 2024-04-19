#!/bin/bash

rm -Rf $(pwd)/build/usage

cmake -Bbuild/usage -H./Usage -DCMAKE_PREFIX_PATH=$(pwd)/install/lib/cmake
cmake --build build/usage --parallel 8
