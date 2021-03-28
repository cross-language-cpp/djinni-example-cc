#project(swifty-store LANGUAGES Swift)
enable_language(Swift)




set(CMAKE_XCODE_ATTRIBUTE_SWIFT_OBJC_BRIDGING_HEADER "${CMAKE_CURRENT_LIST_DIR}/storage-bridge.h")
set(CMAKE_XCODE_ATTRIBUTE_SWIFT_OBJC_INTERFACE_HEADER_NAME storage-bridge.h)

add_executable(swifty_store store_test.swift storage-bridge.h)
target_link_libraries(swifty_store PRIVATE storage)
