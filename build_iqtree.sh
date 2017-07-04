#!/bin/sh
cmake -DIQTREE_FLAGS=omp -DCMAKE_C_COMPILER=clang-5.0 -DCMAKE_CXX_COMPILER=clang++-5.0 ..
