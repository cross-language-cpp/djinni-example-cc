
enable_language(Swift)

# Adding a Swift 'script' test

add_executable(storageswift_test main.swift)
target_link_libraries(storageswift_test PRIVATE storage)
target_include_directories(storageswift_test PUBLIC ${CMAKE_CURRENT_LIST_DIR}/Storage)
#add_test(storageswift_test storageswift_test)
add_test(NAME storageswift_test COMMAND storageswift_test)


# Adding the same test as XCTest ..

#unfortunately, does not work since XCode 12.5,
# cannot find 'XCTAssert' in scope
# see XCTest deprecation notice at the end, and what to use now
# https://developer.apple.com/documentation/xcode-release-notes/xcode-12_5-release-notes
# unfortunately I think this needs to be fixed by cmake

if (BUILD_SWIFT_XCTEST)
    find_package(XCTest REQUIRED)

    xctest_add_bundle(
        xcstorageswift_test
        storage
        store_test.swift
    )
    target_link_libraries(xcstorageswift_test PRIVATE storage)
    target_include_directories(xcstorageswift_test PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Storage)

    xctest_add_test(
        XCTest.storageswift xcstorageswift_test
    )
endif()
