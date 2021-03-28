rm -r build
conan install -if build conanfile.txt
cmake -S . -B build -G Xcode
cmake --build build --parallel 8
