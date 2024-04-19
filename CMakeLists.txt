cmake_minimum_required(VERSION 3.27)

ExternalProject_Add(ZLIB
  GIT_REPOSITORY https://github.com/madler/zlib.git
  GIT_TAG v1.3.1
  GIT_SHALLOW TRUE
  GIT_PROGRESS TRUE
  CMAKE_ARGS -DZLIB_BUILD_EXAMPLES=OFF -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX})

# We actually only know this after ZLIB has been build
set(ZLIB_INC_DIR ${CMAKE_INSTALL_PREFIX}/include)
set(ZLIB_LIB_DIR ${CMAKE_INSTALL_PREFIX}/lib)

configure_file(${CMAKE_CURRENT_LIST_DIR}/config/ZLIBConfig.cmake.in "${CMAKE_INSTALL_PREFIX}/lib/cmake/ZLIBConfig.cmake")
configure_file(${CMAKE_CURRENT_LIST_DIR}/config/ZLIBTargets.cmake.in "${CMAKE_INSTALL_PREFIX}/lib/cmake/ZLIBTargets.cmake")


if (0)
# Boost runtime link can be set to static if we like, BOOST_RUNTIME_LINK=static
ExternalProject_Add(BoostExternal
  URL https://github.com/boostorg/boost/releases/download/boost-1.83.0/boost-1.83.0.tar.gz
  DEPENDS ZLib
  CMAKE_ARGS
  -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
  -DBUILD_SHARED_LIBS=OFF
  -DBOOST_INCLUDE_LIBRARIES=iostreams
  -DBOOST_IOSTREAMS_ENABLE_ZSTD=OFF  
  -DBOOST_ENABLE_MPI=OFF)
endif()

