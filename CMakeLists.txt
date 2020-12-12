cmake_minimum_required (VERSION 3.14)

project (fpds-conversion-utility)

set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} -Wall -Wextra -pedantic  \
          -Wformat=2 -Wno-unused-parameter -Wshadow                  \
          -Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
          -Wredundant-decls -Wnested-externs -Wmissing-include-dirs ")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# MUSL only (not with GLIBC)
if($ENV{FPDS_STATIC} MATCHES "1")
  SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
  SET(BUILD_SHARED_LIBS OFF)
  SET(CMAKE_EXE_LINKER_FLAGS "-static")
endif()

include_directories(${CMAKE_BINARY_DIR})
include_directories(include)
include_directories(extern/progressbar/include/progressbar)
include_directories(extern/threadpool/src)

add_subdirectory(extern/progressbar)
add_subdirectory(app)
add_subdirectory(src)

add_library(threadpool extern/threadpool/src/threadpool.c)
set_target_properties(threadpool PROPERTIES PUBLIC_HEADER
  ${PROJECT_SOURCE_DIR}/include/threadpool/threadpool.h)
