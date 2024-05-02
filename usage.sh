if [ $# -eq 0 ]; then
    echo "Usage: $0 [wasm|static|shared] [debug|release]"
    exit 1
fi

# Convert parameter to lowercase for case-insensitive comparison
param=$(echo "$1" | tr '[:upper:]' '[:lower:]')
param1=$(echo "$2" | tr '[:upper:]' '[:lower:]')

if [ "$param1" = "release" ]; then
   conf="Release"
else
   conf="Debug"
fi

echo "$conf"

if [ "$param" = "shared" ]; then
    echo "Shared."
    cmake -Bbuild/usage -H./Usage -DCMAKE_FIND_ROOT_PATH=$(pwd)/install -DCMAKE_BUILD_TYPE=$conf -DBUILD_SHARED_LIBS=ON
    cmake --build build/usage --parallel 16
    ./build/usage/main
elif [ "$param" = "static" ]; then
    echo "Static."
    cmake -Bbuild/usage -H./Usage -DCMAKE_FIND_ROOT_PATH=$(pwd)/install -DCMAKE_BUILD_TYPE=$conf -DBUILD_SHARED_LIBS=OFF 
    cmake --build build/usage --parallel 16
    ./build/usage/main
elif [ "$param" = "wasm" ]; then (
    echo "Emscripten."
    source "$HOME/github/emsdk/emsdk_env.sh"
    emcmake cmake -Bbuild/usage -H./Usage -DCMAKE_FIND_ROOT_PATH=$(pwd)/install -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=$conf
    cmake --build build/usage --parallel 16
)
else
    echo "Invalid argument. Usage: $0 [wasm|static|shared]"
    exit 1    
fi

