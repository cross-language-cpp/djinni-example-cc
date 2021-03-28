
find_package(doctest)

add_executable(storagecpp_test storagecpp_test.cpp)
target_link_libraries(storagecpp_test storage doctest::doctest)
add_test(storagecpp_test storagecpp_test)

