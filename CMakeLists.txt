cmake_minimum_required (VERSION 3.14)

project (fpds-conversion-utility)

set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} -Wall -Wextra -pedantic  \
          -Wformat=2 -Wno-unused-parameter -Wshadow                  \
          -Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
          -Wredundant-decls -Wnested-externs -Wmissing-include-dirs ")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

if($ENV{FPDS_STATIC} MATCHES "1")
  SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
  SET(BUILD_SHARED_LIBS OFF)
  SET(CMAKE_EXE_LINKER_FLAGS "-static")
endif()

include_directories(${CMAKE_BINARY_DIR})
include_directories(include/progressbar)
include_directories(include/threadpool)

add_subdirectory(include/restyle)
add_subdirectory(lib/progressbar)
add_subdirectory(lib/threadpool)
add_subdirectory(src)
