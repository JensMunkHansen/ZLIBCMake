cmake_minimum_required(VERSION 3.27)

project(Usage)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMake)
include(DumpVariables)

message("CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH}")
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

# Find ZLIB
if (NOT BUILD_SHARED_LIBS)
  set(ZLIB_USE_STATIC_LIBS ON)
endif()
find_package(ZLIB 1.3.1 EXACT REQUIRED)

add_executable(main main.cxx)
target_link_libraries(main PRIVATE ZLIB::ZLIB)

if (EMSCRIPTEN)
  set_target_properties(main PROPERTIES COMPILE_FLAGS "-Os")
  set_target_properties(main PROPERTIES LINK_FLAGS    "-Os -s WASM=1 -s")
endif()

#dump_variables()

if (BUILD_SHARED_LIBS)
  if (MSVC)
    # Not pretty for dynamic libraries
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
  endif()
elseif(EMSCRIPTEN)
  add_custom_command(TARGET main
    POST_BUILD
    COMMAND ${CMAKE_CROSSCOMPILING_EMULATOR} ${CMAKE_CURRENT_BINARY_DIR}/main.js
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  )  
endif()
