cdef extern from "mkl_service.h":
    cdef void mkl_get_version_string (char* buf, int len) nogil

def print_mkl_version():
    cdef int length = 198
    cdef char buff[198]
    mkl_get_version_string(buff, length)
    print(buff)
