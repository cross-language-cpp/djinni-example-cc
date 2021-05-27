cmake_minimum_required(VERSION 3.16.3)
project (xlcpp.HelloDjinni)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

include(CTest)
enable_testing()

find_package(JNI REQUIRED)


include(${CMAKE_BINARY_DIR}/conan_paths.cmake)
include(cmake/djinni_process_idl.cmake)

djinni_process_idl(
  DJINNI_IDL_FILE idl/storage.djinni
  GENARATED_OUT_DIR generated
  VARIABLE_PREFIX DJINI_STORAGE
  NAMESPACE cpplib::djinni
  JAVA_PACKAGE dev.xlcpp.djinni.hello
)


include(${CMAKE_CURRENT_BINARY_DIR}/storage.djinni.cmake)


find_package(djinni-support-lib)


add_library(storage
    SHARED
    # all genearted headers
    ${DJINI_STORAGE_CPP_SOURCE}
    ${DJINI_STORAGE_JNI_SOURCE}
    ${DJINI_STORAGE_OBJC_SOURCE}
    ${DJINI_STORAGE_OBJCPP_SOURCE}
    # until source groups added
    ${DJINI_STORAGE_OBJC_HEADER}
    ${DJINI_STORAGE_JNI_HEADER}
    ${DJINI_STORAGE_CPP_HEADER}
    # our implementation
    src/storage.cpp
)

set_target_properties(storage PROPERTIES
  OUTPUT_NAME "DjinniStorage"
  FRAMEWORK TRUE

  MACOSX_BUNDLE TRUE

  XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC TRUE

#  MACOSX_FRAMEWORK_INFO_PLIST "${CMAKE_CURRENT_LIST_DIR}/cmake/MacOSXBundleInfo.plist.in"
  # "current version" in semantic format in Mach-O binary file
  #        MACOSX_BUNDLE_BUNDLE_NAME "DjinniStorage"
  #        MACOSX_FRAMEWORK_IDENTIFIER "dev.xlcpp.djinni.storage"

  #FRAMEWORK_VERSION C # TODO, a b c ..? only MacOS !

  VERSION 0.0.0
  # "compatibility version" in semantic format in Mach-O binary file
  SOVERSION 0.0.0

  PUBLIC_HEADER "${objec_header_generated}"

  RESOURCE "${BUNDLE_RESOURCES}"

#    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ${APPLE_ID_DEVELOPMENT_TEAM}
)


target_include_directories(storage PUBLIC generated/include)
target_include_directories(storage PRIVATE ${JNI_INCLUDE_DIRS})
target_compile_options(storage PRIVATE -fobjc-arc)
target_link_libraries(storage PUBLIC djinni-support-lib::djinni-support-lib  "-framework Foundation")



find_package(Java REQUIRED)
include(UseJava)

add_jar(jstoreage
  SOURCES
    ${DJINI_STORAGE_JAVA_SOURCE}
  OUTPUT_DIR
    ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
)
get_target_property(JSTORE_JAR_FILE jstoreage JAR_FILE)
get_target_property(JSTORE_CLASSDIR jstoreage CLASSDIR)


add_subdirectory(tests)

