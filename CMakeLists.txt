cmake_minimum_required (VERSION 3.0)

project (fpds-conversion-utility)

set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} -Wall -Wextra -pedantic  \
          -Wformat=2 -Wno-unused-parameter -Wshadow                  \
          -Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
          -Wredundant-decls -Wnested-externs -Wmissing-include-dirs ")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include_directories(include)

add_subdirectory(src)
