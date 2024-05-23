# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/liuyang/learn_cutlass/third_party/cutlass"
  "/home/liuyang/learn_cutlass/build/_deps/extern_cutlass-build"
  "/home/liuyang/learn_cutlass/build/_deps/extern_cutlass-subbuild/extern_cutlass-populate-prefix"
  "/home/liuyang/learn_cutlass/build/_deps/extern_cutlass-subbuild/extern_cutlass-populate-prefix/tmp"
  "/home/liuyang/learn_cutlass/build/_deps/extern_cutlass-subbuild/extern_cutlass-populate-prefix/src/extern_cutlass-populate-stamp"
  "/home/liuyang/learn_cutlass/build/_deps/extern_cutlass-subbuild/extern_cutlass-populate-prefix/src"
  "/home/liuyang/learn_cutlass/build/_deps/extern_cutlass-subbuild/extern_cutlass-populate-prefix/src/extern_cutlass-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/liuyang/learn_cutlass/build/_deps/extern_cutlass-subbuild/extern_cutlass-populate-prefix/src/extern_cutlass-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/liuyang/learn_cutlass/build/_deps/extern_cutlass-subbuild/extern_cutlass-populate-prefix/src/extern_cutlass-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
