include_guard(GLOBAL)
set(djinni_cmake_utils_dir ${CMAKE_CURRENT_LIST_DIR} CACHE INTERNAL "")

macro(djinni_process_idl)

  set(options )
  set(values DJINNI_IDL_FILE GENARATED_OUT_DIR VARIABLE_PREFIX JAVA_PACKAGE NAMESPACE)
  set(lists )

  cmake_parse_arguments(_idldef
      "${options}" "${values}" "${lists}" ${ARGN})

  set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS
      ${_idldef_DJINNI_IDL_FILE}
  )

  find_program(DJINNI_CMD djinni DOC "Path to djinni executable" REQUIRED)


  get_filename_component(name_wle ${_idldef_DJINNI_IDL_FILE} NAME_WLE)
  get_filename_component(name ${_idldef_DJINNI_IDL_FILE} NAME)
  get_filename_component(name_real ${_idldef_DJINNI_IDL_FILE} REALPATH)

  set(_idldef_LIST_OUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/cmake_${name}.generated.txt)
  set(_idldef_CMAKE_FILE ${CMAKE_CURRENT_BINARY_DIR}/${name}.cmake)

  set(skip_djinni_call OFF)
  if(EXISTS ${_idldef_LIST_OUT_FILE})
      if(NOT ${name_real} IS_NEWER_THAN ${_idldef_LIST_OUT_FILE})
          message("-- djiini call not required, already processed ${name}.")
          set(skip_djinni_call ON)
      endif()
  endif()

  if(NOT skip_djinni_call)
    string(REPLACE "." "/" javapath ${_idldef_JAVA_PACKAGE})
    set(java_target "${DJINNI_JAVA_PROJECT}/${javapath}")

    string(REPLACE "::" "/" namespace_path ${_idldef_NAMESPACE})

    set(LIST_FILE ${_idldef_LIST_OUT_FILE})
    set(OUT_FILE ${_idldef_CMAKE_FILE})
    set(VARIABLE_PREFIX ${_idldef_VARIABLE_PREFIX})
    set(arg_cpp_out ${_idldef_GENARATED_OUT_DIR}/${namespace_path}/cpp/)
    set(arg_cpp_header_out ${_idldef_GENARATED_OUT_DIR}/include/${namespace_path}/cpp)
    set(arg_jni_out ${_idldef_GENARATED_OUT_DIR}/${namespace_path}/jni/)
    set(arg_jni_header_out ${_idldef_GENARATED_OUT_DIR}/include/${namespace_path}/jni)
    set(arg_objc_out ${_idldef_GENARATED_OUT_DIR}/${namespace_path}/objc/)
    set(arg_objc_header_out ${_idldef_GENARATED_OUT_DIR}/include/${namespace_path}/objc/)
    set(arg_objcpp_out ${_idldef_GENARATED_OUT_DIR}/${namespace_path}/objcpp/)
    set(arg_java_out ${_idldef_GENARATED_OUT_DIR}/${javapath})
    set(arg_yaml_out ${_idldef_GENARATED_OUT_DIR}/${namespace_path}/yaml/${name}.yaml)

    set(djinni_args
        --idl ${_idldef_DJINNI_IDL_FILE}
     #   --objc-type-prefix Cpp
        --cpp-out ${arg_cpp_out}
        --cpp-header-out ${arg_cpp_header_out}
        --cpp-include-prefix ${namespace_path}/cpp/
        --jni-out ${arg_jni_out}
        --jni-header-out ${arg_jni_header_out}
        --jni-include-prefix ${namespace_path}/jni/
        --jni-include-cpp-prefix ${namespace_path}/cpp/
        --objc-out ${arg_objc_out}
        --objc-header-out ${arg_objc_header_out}
        --objc-include-prefix ${namespace_path}/objc/
        --objcpp-out ${arg_objcpp_out}
        --objcpp-include-objc-prefix ${namespace_path}/objc/
        --objcpp-include-cpp-prefix ${namespace_path}/cpp/
        --java-out ${arg_java_out}
        --java-package ${_idldef_JAVA_PACKAGE}
        --cpp-namespace ${_idldef_NAMESPACE}
        --objcpp-namespace ${_idldef_NAMESPACE}::oc
        --yaml-out ${arg_yaml_out}
        --list-out-files ${_idldef_LIST_OUT_FILE}
        --objc-swift-bridging-header ${name_wle}-umbrella
        --ident-cpp-file FooBar
    )

    message("Generating djinni source files for ${name}")
    execute_process(
      COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_CURRENT_LIST_DIR}/${_idldef_GENARATED_OUT_DIR}
      COMMAND ${DJINNI_CMD} ${djinni_args}
      WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
      COMMAND_ERROR_IS_FATAL LAST
      #COMMAND_ECHO STDOUT
    )

    message("Generating djinni cmake include file for ${name}")
    FILE(READ "${LIST_FILE}" generated_files)
    STRING(REGEX REPLACE ";" "\\\\;" generated_files "${generated_files}")
    STRING(REGEX REPLACE "\n" ";" generated_files "${generated_files}")

    set(CPP_SOURCE "")
    set(CPP_HEADER "")
    set(JNI_SOURCE "")
    set(JNI_HEADER "")
    set(OBJC_SOURCE "")
    set(OBJC_HEADER "")
    set(OBJCPP_SOURCE "")
    set(JAVA_SOURCE "")

    foreach(item ${generated_files})
      if(item MATCHES "^${arg_cpp_out}")
        list(APPEND CPP_SOURCE ${item})
      elseif(item MATCHES "^${arg_cpp_header_out}")
        list(APPEND CPP_HEADER ${item})
      elseif(item MATCHES "^${arg_jni_out}")
        list(APPEND JNI_SOURCE ${item})
      elseif(item MATCHES "^${arg_jni_header_out}")
        list(APPEND JNI_HEADER ${item})
      elseif(item MATCHES "^${arg_objc_out}")
        list(APPEND OBJC_SOURCE ${item})
      elseif(item MATCHES "^${arg_objc_header_out}")
        list(APPEND OBJC_HEADER ${item})
      elseif(item MATCHES "^${arg_objcpp_out}")
        list(APPEND OBJCPP_SOURCE ${item})
      elseif(item MATCHES "^${arg_java_out}")
        list(APPEND JAVA_SOURCE ${item})
      elseif(item MATCHES "^${arg_yaml_out}")
        # ignore
      else()
        message(WARNING "Unhandled generated file: " ${item})
      endif()

    endforeach()

    string (REPLACE ";" " " CPP_SOURCE "${CPP_SOURCE}")
    string (REPLACE ";" " " CPP_HEADER "${CPP_HEADER}")
    string (REPLACE ";" " " JNI_SOURCE "${JNI_SOURCE}")
    string (REPLACE ";" " " JNI_HEADER "${JNI_HEADER}")
    string (REPLACE ";" " " OBJC_SOURCE "${OBJC_SOURCE}")
    string (REPLACE ";" " " OBJC_HEADER "${OBJC_HEADER}")
    string (REPLACE ";" " " OBJCPP_SOURCE "${OBJCPP_SOURCE}")
    string (REPLACE ";" " " JAVA_SOURCE "${JAVA_SOURCE}")


    configure_file(${djinni_cmake_utils_dir}/djinni_generated_files.cmake.in
                  ${OUT_FILE}
                  @ONLY
    )
  endif()
endmacro()


