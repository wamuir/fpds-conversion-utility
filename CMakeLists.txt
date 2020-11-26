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

file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/include)

file(GLOB files "${CMAKE_SOURCE_DIR}/src/xsl/*" "${CMAKE_SOURCE_DIR}/src/sql/*")
foreach(file ${files})
	get_filename_component(pt ${file} DIRECTORY)
	get_filename_component(fn ${file} NAME)
	get_filename_component(bn ${file} NAME_WLE)
	execute_process(
		COMMAND xxd -i ${fn} ${CMAKE_SOURCE_DIR}/include/${bn}.h
		WORKING_DIRECTORY ${pt}
	)
endforeach()

include_directories(include)

add_subdirectory(src)
