from libc.math cimport log2, pow, sqrt
import numpy as np
cimport numpy as np

cdef double[::1] WienerBridge(int nsteps, double T, double endval):
    cdef double[::1] wsamples = np.empty(nsteps + 1, dtype=np.float64)
    cdef int num_bisect = <int>log2(nsteps)
    cdef double tjump = T;
    cdef int ijump = nsteps - 1
    cdef int left = 0
    cdef int right = 0
    cdef int i = 0
    cdef int limit = 0
    cdef double a = 0.0
    cdef double b = 0.0
    cdef int i, j

    for i in range(num_bisect):
        left = 0
        i = ijump / 2 + 1
        right = ijump + 1
        limit = <int>(pow(2, k))

        for j in range(limit):
            a = 0.5 * (wsamples[left] + wsamples[right])
            b = 0.5 * sqrt(tjump)
            wsamples[i] = a + b 
            right += ijump + 1
            left += ijump + 1
            i += ijump + 1

        ijump /= 2
        tjump /= 2.0

    return np.diff(wsamples)
    
 
