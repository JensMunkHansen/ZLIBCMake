cmake_minimum_required(VERSION 3.27)

project(Artifactory
  LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMake)
include(DumpVariables)

include(ExternalProject)

ExternalProject_Add(ZLIB
  GIT_REPOSITORY https://github.com/madler/zlib.git
  GIT_TAG v1.3.1
  GIT_SHALLOW TRUE
  CMAKE_ARGS -DZLIB_BUILD_EXAMPLES=OFF -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX})


ExternalProject_Add(BoostExternal
  URL https://github.com/boostorg/boost/releases/download/boost-1.83.0/boost-1.83.0.tar.gz
  DEPENDS ZLIB
  CMAKE_ARGS
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DBUILD_SHARED_LIBS=OFF
  -DZLIB_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include
  -DZLIB_USE_STATIC_LIBS=ON
  -DBOOST_INCLUDE_LIBRARIES=iostreams
  -DBOOST_IOSTREAMS_ENABLE_ZSTD=OFF  
  -DBOOST_ENABLE_MPI=OFF)


# We simply copy the standard FindZLIB.cmake into zlib-targets.cmake and make zlib-config.cmake include this
configure_file(${CMAKE_CURRENT_LIST_DIR}/config/zlib-config.cmake.in "${CMAKE_INSTALL_PREFIX}/lib/cmake/zlib-config.cmake")
configure_file(${CMAKE_CURRENT_LIST_DIR}/config/FindZLIB.cmake "${CMAKE_INSTALL_PREFIX}/lib/cmake/zlib-targets.cmake")


