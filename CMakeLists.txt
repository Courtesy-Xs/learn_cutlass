cmake_minimum_required(VERSION 3.26)
project(learn_cutlass LANGUAGES CXX CUDA)

set(CUDA_NVCC_FLAGS "-arch=sm90")

set(CMAKE_CUDA_ARCHITECTURES 90 90a)
set(THIRD_PARTY_PATH    ${CMAKE_SOURCE_DIR}/third_party)
set(CMAKE_MODULE_PATH   ${CMAKE_SOURCE_DIR}/cmake)

find_package(CUDAToolkit)

include(cmake/cutlass.cmake)

add_executable(CutlassTest test_cutlass.cu)

set_target_properties(CutlassTest PROPERTIES CUDA_ARCHITECTURES "90a")

target_include_directories(CutlassTest  PUBLIC  ${THIRD_PARTY_PATH}/cutlass/include/)