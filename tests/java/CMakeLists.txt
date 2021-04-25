
find_package(Java REQUIRED)
include(UseJava)


#set(CMAKE_JAVA_COMPILE_FLAGS "-source" "7" "-target" "7")


set(JARNAME StorageJavaTest)
add_jar(${JARNAME}
SOURCES
    com/dropbox/djinni/NativeLibLoader.java
    StorageTest.java
)

get_target_property(_jarFile ${JARNAME} JAR_FILE)
get_target_property(_classDir ${JARNAME} CLASSDIR)

message(STATUS "Jar file ${_jarFile}")
message(STATUS "Class compiled to ${_classDir}")

add_test(NAME storagejava_test COMMAND ${Java_JAVA_EXECUTABLE} -cp ${_jarFile} ${JARNAME})


