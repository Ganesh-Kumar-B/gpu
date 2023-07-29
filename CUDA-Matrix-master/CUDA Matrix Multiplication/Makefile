CXX = g++
NVCC = nvc++
CXXFLAGS = -Werror -Wextra -Wall -pedantic -std=c++17 -g
NVFLAGS = -Xcompiler -rdynamic -lineinfo
TRASH = main *.o

all: build

.PHONY: build
build:
	$(NVCC) $(NVFLAGS) -c KernelGpu.cu main.cu
	$(CXX) $(CXXFLAGS) -o main main.o KernelGpu.o -L/opt/nvidia/hpc_sdk/Linux_x86_64/23.5/cuda/12.1/lib64 -lcudart -lcuda

.PHONY: run
run: build
	./main

.PHONY: clean
clean:
	$(RM) $(TRASH)