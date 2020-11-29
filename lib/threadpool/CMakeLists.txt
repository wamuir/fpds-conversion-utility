add_library(threadpool threadpool.c)

set_target_properties(threadpool PROPERTIES PUBLIC_HEADER
    ${PROJECT_SOURCE_DIR}/include/threadpool/threadpool.h)

install(
    TARGETS threadpool
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include/threadpool
)
