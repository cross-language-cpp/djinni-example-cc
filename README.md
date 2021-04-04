# This is a simple hello world

This is just some example how to use cmake, C++, Objective-C and Swift together with djinni. (Java up to come)
It does nothing interesting or useful, just demonstrate a possible project setup.

Early state, just MacOS support, since it's Objective-C / Swift focused.

## Getting started

Install conan, if you do not have it already

Clone this directory and change into it

    git clone https://gitlab.com/a4z/xlcpp-hello.git

    cd xlcpp-hello

Install dependencies:

    conan install -if build conanfile.txt

If this fails due to missing packages for your OSX configuration, please do what the command line help text suggests

Build the project

    cmake -S . -B build -G Ninja
    cmake --build build
    cmake --build build --target test


Now you can start playing with the code and build.

## Some implementation detail.

The usage of the djinni generator is opinionated.
All public headers are generated into an extra folder, cmake install and so a binary delivery could easily be done.

The file generation happens during cmake configure time. If you change the djinni idl file, the output folder (generated) will be removed, and all files will be re-generated. This ensures no artifacts stay on disk after renaming a class.

A file is generated into the build folder, setting some variable names, and this file gets included.
The variable names contain the source files, they re added to the library target.

For the rest, it's best to look at the source, it's tried to be kept as simple as possible.

