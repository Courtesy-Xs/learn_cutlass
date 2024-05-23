cmake_minimum_required(VERSION 3.26)
project("learn_cutlass")

set(THIRD_PARTY_PATH    ${CMAKE_SOURCE_DIR}/third_party/)
set(CMAKE_MODULE_PATH   ${CMAKE_SOURCE_DIR}/cmake/)

include(cmake/cutlass.cmake)

add_executable(CutlassTest test_cutlass.cc)

add_dependencies(CutlassTest extern_cutlass)

