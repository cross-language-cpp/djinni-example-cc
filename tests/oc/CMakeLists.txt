
enable_language(OBJC)


# TODO , das um framework ....
find_library(FOUNDATION Foundation)
if (NOT FOUNDATION)
    message(FATAL_ERROR "FOUNDATION not found")
endif()

add_executable(storageoc_test storageoc_test.m)
#target_link_libraries(storageoc_test storage ${FOUNDATION})
target_link_libraries(storageoc_test storage)
add_test(NAME storageoc_test COMMAND storageoc_test)


# There is no reason why this is required but it seems it is ... and this is bad
add_custom_command(TARGET storageoc_test
    POST_BUILD COMMAND
    ${CMAKE_INSTALL_NAME_TOOL} -add_rpath "@executable_path/../lib"
    $<TARGET_FILE:storageoc_test>)
# it is interesting that this is only required for the storageoc_test,
# not for the same in C++ or Swift, and not for the xctest


# Adding the same test as XCTest ..

find_package(XCTest REQUIRED)

xctest_add_bundle(
    xcstorageoc_test
    storage
    storageoc_test.m
)

xctest_add_test(
    XCTest.storageoc xcstorageoc_test
)
