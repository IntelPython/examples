# Using Cython with the Intel Compiler and MKL

This is a minimal example of using the Intel compiler with Cython and MKL.
To build this example, run
```
bash cy.sh
```
which creates `mkl_cython.so`, which can be imported and used in a regular python script:
```
python mkl_version.py
>>>Intel(R) Math Kernel Library Version 2017.0.0 Product Build 20160801 for Intel(R) 64 architecture applications
```
