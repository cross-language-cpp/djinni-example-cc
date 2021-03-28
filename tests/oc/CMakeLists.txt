
enable_language(OBJC)

find_library(FOUNDATION Foundation)
if (NOT FOUNDATION)
    message(FATAL_ERROR "FOUNDATION not found")
endif()

add_executable(storageoc_test storageoc_test.m)
target_link_libraries(storageoc_test storage ${FOUNDATION})
add_test(storageoc_test storageoc_test)

