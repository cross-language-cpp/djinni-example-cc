
find_package(Java REQUIRED)
include(UseJava)

set(JARNAME StorageJavaTest)
add_jar(${JARNAME}
  SOURCES
    dev/xlcpp/djinni/NativeLibLoader.java
    StorageJavaTest.java
  OUTPUT_DIR
    ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}

  INCLUDE_JARS
    jstoreage

)

get_target_property(_jarFile ${JARNAME} JAR_FILE)
get_target_property(_classDir ${JARNAME} CLASSDIR)

# all that required ? Anyway, it works ... :-)
string(CONCAT _JAVA_TESTS_CLASSPATH
"${JSTORE_JAR_FILE}:"
"${JSTORE_CLASSDIR}:"
"${_CLASSDIR}:"
"${_jarFile}"
)

message(STATUS "1 JSTORE_JAR_FILE file ${JSTORE_JAR_FILE}")
message(STATUS "1 JSTORE_CLASSDIR compiled to ${JSTORE_CLASSDIR}")
message(STATUS "_JAVA_TESTS_CLASSPATH compiled to ${_JAVA_TESTS_CLASSPATH}")


message(STATUS "Jar file ${_jarFile}")
message(STATUS "Class compiled to ${_classDir}")
message(STATUS "RUN: ${Java_JAVA_EXECUTABLE} -cp ${_JAVA_TESTS_CLASSPATH} ${JARNAME}")

add_test(NAME storagejava_test
    COMMAND ${Java_JAVA_EXECUTABLE} -ea -cp ${_JAVA_TESTS_CLASSPATH} ${JARNAME} $<TARGET_FILE:storage>
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)


