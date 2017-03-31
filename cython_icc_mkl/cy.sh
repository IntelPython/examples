#!/bin/bash -x

# Copyright (c) <YEAR>, Intel Corporation
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Intel Corporation nor the names of its contributors
#       may be used to endorse or promote products derived from this software
#       without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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