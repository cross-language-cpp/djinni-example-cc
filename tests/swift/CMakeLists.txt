
enable_language(Swift)


#set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/Storage)


# Adding a Swift 'script' test

add_executable(storageswift_test main.swift)
target_link_libraries(storageswift_test PRIVATE storage)
target_include_directories(storageswift_test PUBLIC ${CMAKE_CURRENT_LIST_DIR}/Storage)
add_test(storageswift_test storageswift_test)


# Adding a XCTest ..

find_package(XCTest REQUIRED)

#add_executable(storageswift_test store_test.swift)
xctest_add_bundle(
    xcstorageswift_test
    storage
    store_test.swift
)
target_link_libraries(xcstorageswift_test PRIVATE storage)
target_include_directories(xcstorageswift_test PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Storage)

xctest_add_test(
    XCTest.storage xcstorageswift_test
)
