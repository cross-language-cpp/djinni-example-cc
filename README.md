# This is a simple hello world

This is just some example how to use cmake, C++, Objective-C and Swift together with djinni. (Java up to come)
It does nothing interesting or useful, just demonstrate a possible project setup.

Early state, just MacOS support, since it's Objective-C / Swift focused.

Install conan, and (for now) add this remote:

    conan remote add xlcpp https://a4z.jfrog.io/artifactory/api/conan/xlcpp-conan-dev-local


Clone this directory and change into it

    git clone ...
    cd hello-djinni

Then run the build:

    conan install -if build conanfile.txt -r xlcpp
    cmake -S . -B build -G Ninja
    cmake --build build
    cmake --build build --target test


## Some implementation detail.

The usage of the djinni generator is opinionated.
All public headers are generated into an extra folder, cmake install and so a binary delivery could easily be done.

The file generation happens during cmake configure time. If you change the djinni idl file, the output folder (generated) will be removed, and all files will be re-generated. This ensures no artifacts stay on disk after renaming a class.

A file is generated into the build folder, setting some variable names, and this file gets included.
The variable names contain the source files, they re added to the library target.

For the rest, it's best to look at the source, it's tried to be kept as simple as possible.

