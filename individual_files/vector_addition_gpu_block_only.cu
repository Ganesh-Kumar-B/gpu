#include<stdio.h>
#include<stdlib.h>
#include<iostream>
#include<cuda_runtime_api.h>
#include<assert.h>
#include<typeinfo> 

struct matrix{
	int n_x;
	void* data;

	matrix(int nx){

		n_x = nx;
		data = (void*)malloc(nx*sizeof(double));

	}

}



__global__  void add(double *a, double *b, double *c){

	c[blockIdx.x] = a[blockIdx.x] + c[blockIdx.x];
}



void fill_array(double *data) {
	for(int idx=0;idx<N;idx++)
		data[idx] = idx;
}



void print_array(matrix &a )
{

for(int idx = 0; idx< a.n_x; idx++)
	std::cout<<a.data[idx]<<std::endl;


}





int main() {
		int N = 550;

		matrix a(N);
		matrix b(N);
		matrix c(N);

		matrix d_a(N);
		matrix d_b(N);
		matrix d_c(N);

		fill_array((double*) a.data);
		fill_array((double*) b.data);
		std::cout<<a.data[5]<<std::endl;

        // Alloc space for device copies of a, b, c
        cudaError_t result1 = cudaMalloc(&d_a.data, d_a.n_x * sizeof(double));
        cudaError_t result2 = cudaMalloc(&d_b.data, d_b.n_x * sizeof(double));
        cudaError_t result3 = cudaMalloc(&d_c.data, d_c.n_x * sizeof(double));
		assert(result1 == cudaSuccess || result2 == cudaSuccess || result3 == cudaSuccess);



       // Copy inputs to device
        result1 = cudaMemcpy(&d_a.data, &a.data, d_a.n_x * sizeof(double), cudaMemcpyHostToDevice);
        result2 = cudaMemcpy(&d_b.data, &b.data, d_b.n_x * sizeof(double), cudaMemcpyHostToDevice);
		assert(result1 == cudaSuccess || result2 == cudaSuccess);


		add<<<N,1>>> add((double*)d_a.data,(double*)d_b.data,(double*)d_c.data )


        // Copy result back to host
        cudaError_t result = cudaMemcpy(&c.data, &d_c.data, d_a.n_x * sizeof(double), cudaMemcpyDeviceToHost);
		assert(result == cudaSuccess);





        cudaFree(d_a.data); cudaFree(d_b.data); cudaFree(d_c.data);



	return 0;
}
