cmake_minimum_required(VERSION 3.26)
project(learn_cutlass LANGUAGES CXX CUDA)

set(CUDA_NVCC_FLAGS "-arch=sm90")

set(THIRD_PARTY_PATH    ${CMAKE_SOURCE_DIR}/third_party)
set(CMAKE_MODULE_PATH   ${CMAKE_SOURCE_DIR}/cmake)

find_package(CUDAToolkit)

include(cmake/cutlass.cmake)

add_executable(CutlassTest test_cutlass.cu)

target_include_directories(CutlassTest  PUBLIC  ${THIRD_PARTY_PATH}/cutlass/include/)
target_link_libraries(CutlassTest PUBLIC extern_cutlass)