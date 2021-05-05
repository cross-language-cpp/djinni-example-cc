enable_language(OBJC)
if(APPLE)
    set(MACOSX_RPATH TRUE)
    #set(CMAKE_MACOSX_RPATH ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_MACOSX_RPATH "@executable_path/../lib")

endif()


add_subdirectory(cpp)

add_subdirectory(oc)
add_subdirectory(swift)
add_subdirectory(java)
