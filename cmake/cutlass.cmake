# include(ExternalProject)

# set(CUTLASS_PREFIX_DIR ${THIRD_PARTY_PATH}/cutlass)
# set(CUTLASS_SOURCE_DIR ${THIRD_PARTY_PATH}/cutlass)
# set(CUTLASS_GIT_REPOSITORY https://github.com/NVIDIA/cutlass.git)
# set(CUTLASS_GIT_TAG "main")

# ExternalProject_Add(
#   extern_cutlass
#   GIT_REPOSITORY https://github.com/NVIDIA/cutlass.git
#   GIT_TAG ${CUTLASS_GIT_TAG}
#   PREFIX ${CUTLASS_PREFIX_DIR}
#   SOURCE_DIR ${CUTLASS_SOURCE_DIR}
#   BINARY_DIR ${CMAKE_BINARY_DIR}
#   UPDATE_COMMAND ""
#   CONFIGURE_COMMAND ""
#   BUILD_COMMAND ""
#   INSTALL_COMMAND ""
#   TEST_COMMAND "")

# include_directories("${THIRD_PARTY_PATH}/cutlass/include/")


include(FetchContent)

FetchContent_Declare(
    extern_cutlass 
    GIT_REPOSITORY https://github.com/NVIDIA/cutlass.git 
    GIT_TAG "main"
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/third_party/cutlass/
)

FetchContent_MakeAvailable(extern_cutlass)
