cmake_minimum_required(VERSION 3.27)

project(Usage)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMake)
include(DumpVariables)

#list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_FIND_ROOT_PATH})

message("CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH}")
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

# set(CMAKE_FIND_ROOT_PATH  "/home/jmh/github/ZLIBCMake/install")

# Find ZLIB
set(ZLIB_USE_STATIC_LIBS 1)
find_package(ZLIB 1.3.1 EXACT REQUIRED)

cmake_dump_variables(zlib)
cmake_dump_variables(ZLIB)

add_executable(main main.cxx)
if (WIN32)
  target_include_directories(main PRIVATE ${ZLIB_INCLUDE_DIRS})
endif()
target_link_libraries(main PRIVATE ${ZLIB_LIBRARIES})
