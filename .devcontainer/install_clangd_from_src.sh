#!/usr/bin/env bash

# Exit immediately if any command exits with a non-zero status (i.e., it fails).
set -e

git clone --depth=1 https://github.com/llvm/llvm-project.git

cd llvm-project
mkdir build && cd build
cmake -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DCMAKE_INSTALL_PREFIX=~/tools/llvm -DCMAKE_BUILD_TYPE=Release ../llvm
make -j 16
make install

