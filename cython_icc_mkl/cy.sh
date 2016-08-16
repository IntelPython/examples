#!/bin/bash -x

if [ ! -f ./build ]; then
    mkdir build
fi

if [ ! -f ./build/temp.linux-x86_64-2.7 ]; then
    mkdir build/temp.linux-x86_64-2.7
fi

cython -a mkl_cython.pyx

icc -I/localdisk/work/chogan/py2_rc1/include \
    -I/localdisk/work/chogan/py2_rc1/include/python2.7 \
    -I/localdisk/tools/intel/compilers_and_libraries/linux/include \
    -I/localdisk/tools/intel/compilers_and_libraries/linux/mkl/include \
    -DNDEBUG -O2 -Wall -fPIC -c mkl_cython.c -o build/temp.linux-x86_64-2.7/mkl_cython.o

icc -shared -Wl,-rpath=$ORIGIN/../lib/:/localdisk/work/chogan/py2_rc1/lib \
    -L/localdisk/work/chogan/py2_rc1/lib \
    -L/localdisk/tools/intel/compilers_and_libraries/linux/lib/intel64 \
    -lmkl_rt build/temp.linux-x86_64-2.7/mkl_cython.o -o mkl_cython.so