cmake_minimum_required(VERSION 3.27)

project(Artifactory
  LANGUAGES CXX)

include(ExternalProject)

ExternalProject_Add(ZLIB
  GIT_REPOSITORY https://github.com/madler/zlib.git
  GIT_TAG v1.3.1
  GIT_SHALLOW TRUE
  GIT_PROGRESS TRUE
  CMAKE_ARGS -DZLIB_BUILD_EXAMPLES=OFF -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX})

# We simply copy the standard FindZLIB.cmake into zlib-targets.cmake and make zlib-config.cmake include this
configure_file(${CMAKE_CURRENT_LIST_DIR}/config/zlib-config.cmake.in "${CMAKE_INSTALL_PREFIX}/lib/cmake/zlib-config.cmake")
configure_file(${CMAKE_CURRENT_LIST_DIR}/config/FindZLIB.cmake "${CMAKE_INSTALL_PREFIX}/lib/cmake/zlib-targets.cmake")



