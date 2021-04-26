
find_package(Java REQUIRED)
include(UseJava)



set(JARNAME StorageJavaTest)
add_jar(${JARNAME}
SOURCES
    dev/xlcpp/djinni/NativeLibLoader.java
    StorageJavaTest.java
    ${CMAKE_SOURCE_DIR}/generated/dev/xlcpp/djinni/hello/Storage.java
    ${CMAKE_SOURCE_DIR}/generated/dev/xlcpp/djinni/hello/Data.java;

)

get_target_property(_jarFile ${JARNAME} JAR_FILE)
get_target_property(_classDir ${JARNAME} CLASSDIR)

message(STATUS "Jar file ${_jarFile}")
message(STATUS "Class compiled to ${_classDir}")
message(STATUS "RUN: ${Java_JAVA_EXECUTABLE} -cp ${_jarFile} ${JARNAME}")

add_test(NAME storagejava_test
    COMMAND ${Java_JAVA_EXECUTABLE} -cp ${_jarFile} ${JARNAME} $<TARGET_FILE:storage>
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)


