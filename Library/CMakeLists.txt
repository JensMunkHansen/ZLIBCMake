cmake_minimum_required(VERSION 3.27)

project(Artifactory
  LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMake)
include(DumpVariables)

include(ExternalProject)

message("CMAKE_GENERATOR_PLATFORM: ${CMAKE_GENERATOR_PLATFORM}")
message("CMAKE_GENERATOR_TOOLSET: ${CMAKE_GENERATOR_TOOLSET}")
message("CMAKE_TOOLCHAIN_FILE: ${CMAKE_TOOLCHAIN_FILE}")

if (EMSCRIPTEN)
  set(BUILD_SHARED_LIBS OFF)
endif()

ExternalProject_Add(ZLIB
  GIT_REPOSITORY https://github.com/madler/zlib.git
  GIT_TAG v1.3.1
  GIT_SHALLOW TRUE
  CMAKE_ARGS
    -DZLIB_BUILD_EXAMPLES=OFF
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE})


set(_ZLIB_ROOT ${CMAKE_INSTALL_PREFIX}/include)
# We simply copy the standard FindZLIB.cmake into zlib-targets.cmake and make zlib-config.cmake include this
configure_file(${CMAKE_CURRENT_LIST_DIR}/config/zlib-config.cmake.in "${CMAKE_INSTALL_PREFIX}/lib/cmake/ZLIB/zlib-config.cmake" @ONLY)
configure_file(${CMAKE_CURRENT_LIST_DIR}/config/FindZLIB.cmake "${CMAKE_INSTALL_PREFIX}/lib/cmake/ZLIB/zlib-targets.cmake" @ONLY)
configure_file(${CMAKE_CURRENT_LIST_DIR}/config/SelectLibraryConfigurations.cmake "${CMAKE_INSTALL_PREFIX}/lib/cmake/ZLIB/SelectLibraryConfigurations.cmake" @ONLY)



