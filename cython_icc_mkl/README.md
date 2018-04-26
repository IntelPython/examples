# Using Cython with the Intel Compiler and MKL

This is a minimal example of using the Intel compiler with Cython and MKL.

**Assumption:** You've sourced **icc**-related environment variables (via **iccvars.sh**) - i.e. you have **icc** on **PATH** and icc-related header-files and libraries on **CPATH** and **LD_LIBRARY_PATH**, respectively.

1. If you don't have a local installation of Python, the following can be performed to setup a miniminal configuration required to run this example:
    1. [Get miniconda](https://conda.io/miniconda.html): ```wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh```
    2. Install miniconda: ```bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda3```
    3. Update miniconda: ```./miniconda3/bin/conda update -c anaconda conda -y```
    4. Create a conda-environment with required dependencies: ```./miniconda3/bin/conda create -n cy_icc_test -c intel python=3.6 mkl-devel cython -y```
    5. Activate conda-environment: ```source ./miniconda3/bin/activate cy_icc_test```

    Once the conda-environment is activated (i.e. Step.5), the default python (\`which python\`) would be the one with all the required dependencies installed.
    
    You can deactivate this conda-environment after running this example: ```source ./miniconda3/bin/deactivate```

2. If you have a local Python installation:
    1. Install required dependencies: ```<absolute_path_to_local_Py_installation>/bin/pip install cython mkl-devel```
    2. Update **cy.sh** to ensure that correct library directory and include directory are used while building this extension: 
      In **cy.sh**:
        1. replace ```cython``` with ```<absolute_path_to_local_Py_installation>/bin/cython```
        2.  replace **all** instances of **\`python3-config --exec-prefix\`** with ```<absolute_path_to_local_Py_installation>```
        3. replace **\`python3-config --exec-prefix\`/include/python3.6m** with the absolute path to include-directory of CPython's header files, for e.g. ```<absolute_path_to_local_Py_installation>/include/python2.7```

To build this example, run ```bash cy.sh```
which creates `mkl_cython.so`, that can be imported and used in a regular python script. To check if everything built correctly, run:
```
python mkl_version.py
```
