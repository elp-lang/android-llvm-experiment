project(android_elp)
cmake_minimum_required(VERSION 3.22)

add_library(hello_world SHARED build/intermediates/llvm/dummy.cpp build/intermediates/llvm/hello_world.o)
target_link_libraries(hello_world android)