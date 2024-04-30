#!/bin/bash

rm -Rf $(pwd)/build/usage

emcmake cmake -Bbuild/usage -H./Usage -DCMAKE_FIND_ROOT_PATH=$(pwd)/install
cmake --build build/usage --parallel 8

