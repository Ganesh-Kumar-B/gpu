#pragma once
#include "CpuGpuMat.h"

#ifdef __cplusplus
extern "C" {
#endif

void gpuMatrixMultiplication(struct CpuGpuMat* Mat1, struct CpuGpuMat* Mat2, struct CpuGpuMat* Mat3);


#ifdef __cplusplus
}
#endif