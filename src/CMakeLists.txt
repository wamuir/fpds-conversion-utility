add_library(fpds-converter converter.c)

target_link_libraries(fpds-converter threadpool)

find_package (LibXml2)
if (LIBXML2_FOUND)
  include_directories(${LIBXML2_INCLUDE_DIRS})
  add_definitions(${LIBXML2_DEFINITIONS})
  target_link_libraries(fpds-converter ${LIBXML2_LIBRARIES})
endif (LIBXML2_FOUND)

find_package (LibXslt)
if (LIBXSLT_FOUND)
  include_directories(${LIBXSLT_INCLUDE_DIRS})
  add_definitions(${LIBXSLT_DEFINITIONS})
  target_link_libraries(fpds-converter ${LIBXSLT_LIBRARIES})
endif (LIBXSLT_FOUND)

find_package(LibUuid)
if (LIBUUID_FOUND)
  include_directories(${LIBUUID_INCLUDE_DIRS})
  target_link_libraries (fpds-converter ${LIBUUID_LIBRARIES})
endif (LIBUUID_FOUND)

find_package (SQLite3)
if (SQLite3_FOUND)
  include_directories(${SQLite3_INCLUDE_DIRS})
  target_link_libraries (fpds-converter ${SQLite3_LIBRARIES})
endif (SQLite3_FOUND)

find_package(LibLZMA)
if (LIBLZMA_FOUND)
  include_directories(${LIBLZMA_INCLUDE_DIRS})
  target_link_libraries(fpds-converter ${LIBLZMA_LIBRARIES})
endif (LIBLZMA_FOUND)

find_package(ZLIB)
if (ZLIB_FOUND)
  include_directories(${ZLIB_INCLUDE_DIRS})
  target_link_libraries(fpds-converter ${ZLIB_LIBRARIES})
endif (ZLIB_FOUND)

set(CURSES_NEED_NCURSES TRUE)
find_package(Curses)
if (CURSES_FOUND)
 include_directories(${CURSES_INCLUDE_DIRS})
  target_link_libraries(fpds-converter ${CURSES_LIBRARIES})
endif (CURSES_FOUND)

find_package(Threads)
if (Threads_FOUND)
  target_link_libraries(fpds-converter ${CMAKE_THREAD_LIBS_INIT})
endif (Threads_FOUND)

file(GLOB files xsl/* sql/*)
foreach(file ${files})
        get_filename_component(pt ${file} DIRECTORY)
        get_filename_component(fn ${file} NAME)
        get_filename_component(bn ${file} NAME_WLE)
        execute_process(
                COMMAND xxd -i ${fn} ${CMAKE_BINARY_DIR}/include/restyle/${bn}.h
                WORKING_DIRECTORY ${pt}
        )
endforeach()
