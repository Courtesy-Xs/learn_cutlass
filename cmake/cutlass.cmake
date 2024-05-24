include(FetchContent)

FetchContent_Declare(
    extern_cutlass 
    GIT_REPOSITORY https://github.com/NVIDIA/cutlass.git 
    GIT_TAG "main"
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third_party/cutlass/
)

FetchContent_MakeAvailable(extern_cutlass)
