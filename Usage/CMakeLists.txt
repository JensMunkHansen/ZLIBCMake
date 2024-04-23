cmake_minimum_required(VERSION 3.27)

project(Usage)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMake)
include(DumpVariables)

#list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_FIND_ROOT_PATH})

message("CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH}")
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

# set(CMAKE_FIND_ROOT_PATH  "/home/jmh/github/ZLIBCMake/install")

# Find ZLIB
if (NOT BUILD_SHARED_LIBS)
  set(ZLIB_USE_STATIC_LIBS ON)
endif()
find_package(ZLIB 1.3.1 EXACT REQUIRED)

find_package(Boost COMPONENTS iostreams REQUIRED)

add_executable(main main.cxx)
target_link_libraries(main PRIVATE ZLIB::ZLIB)
target_link_libraries(main PUBLIC Boost::boost Boost::iostreams)
cmake_dump_variables()

if (BUILD_SHARED_LIBS)

  # Not pretty
  string(REGEX REPLACE "[.]lib" ".dll" ZLIB_LIBRARY_DEBUG_RUNTIME ${ZLIB_LIBRARY_DEBUG})
  string(REGEX REPLACE "/lib/" "/bin/" ZLIB_LIBRARY_DEBUG_RUNTIME ${ZLIB_LIBRARY_DEBUG_RUNTIME})
  string(REGEX REPLACE "[.]lib" ".dll" ZLIB_LIBRARY_RELEASE_RUNTIME ${ZLIB_LIBRARY_RELEASE})
  string(REGEX REPLACE "/lib/" "/bin/" ZLIB_LIBRARY_RELEASE_RUNTIME ${ZLIB_LIBRARY_RELEASE_RUNTIME})
  add_custom_command(TARGET main POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
    ${ZLIB_LIBRARY_RELEASE_RUNTIME} $<TARGET_FILE_DIR:main> || (exit 0)
    VERBATIM
  )
  add_custom_command(TARGET main POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
    ${ZLIB_LIBRARY_DEBUG_RUNTIME} $<TARGET_FILE_DIR:main> || (exit 0)
    VERBATIM
  )

  if (0)
    add_custom_command( TARGET main POST_BUILD
      COMMAND ${CMAKE_COMMAND}
      "-DZLIB_LIBRARY_DEBUG=${ZLIB_LIBRARY_DEBUG}"
      "-DZLIB_LIBRARY_RELEASE=${ZLIB_LIBRARY_RELEASE}"
      "-DOUTPUT_DIR=$<TARGET_FILE_DIR:main>"
      -P "${CMAKE_CURRENT_LIST_DIR}/copyzlib.cmake")
  endif()
endif()
