#include<stdio.h>
#include<stdlib.h>
#include<iostream>
#include<cuda_runtime_api.h>
#include<assert.h>
#include<typeinfo> 











template<typename T>
struct matrix{

	int n_x;
	T* data;

	
	matrix(int nx){

		n_x = nx;
		data = (T*)malloc(nx*sizeof(T));

	}

}
;

template<typename T>
__global__ void device_add(T *a, T *b, T *c) {

        c[threadIdx.x] = a[threadIdx.x] + b[threadIdx.x];
}



template<typename T>
void fill_array(matrix<T> &a) {
	
	for(int idx=0;idx<a.n_x;idx++)
		a.data[idx] = idx;
}


template<typename T>
void print_array(matrix<T> &a )
{
	for(int idx = 0; idx< a.n_x; idx++)
		std::cout<<a.data[idx]<<std::endl;


}





int main() {
		int N = 500;

		matrix<double> a(N);
		matrix<double> b(N);
		matrix<double> c(N);

		matrix<double> d_a(N);
		matrix<double> d_b(N);
		matrix<double> d_c(N);

		fill_array(a);
		fill_array(b);
		std::cout<<a.data[5]<<std::endl;

        // Alloc space for device copies of a, b, c
        cudaError_t result1 = cudaMalloc((void**)&d_a.data, d_a.n_x * sizeof(a.data[0]));
        cudaError_t result2 = cudaMalloc((void**)&d_b.data, d_b.n_x * sizeof(b.data[0]));
        cudaError_t result3 = cudaMalloc((void**)&d_c.data, d_c.n_x * sizeof(c.data[0]));
	assert(result1 == cudaSuccess || result2 == cudaSuccess || result3 == cudaSuccess);



       // Copy inputs to device
        result1 = cudaMemcpy((void*)d_a.data,(void*) a.data, d_a.n_x * sizeof(d_a.data[0]), cudaMemcpyHostToDevice);
        result2 = cudaMemcpy((void*)d_b.data,(void*) b.data, d_b.n_x * sizeof(d_b.data[0]), cudaMemcpyHostToDevice);
	assert(result1 == cudaSuccess || result2 == cudaSuccess);

	device_add<<<1,N>>>(d_a.data,d_b.data, d_c.data);  

        // Copy result back to host
        cudaError_t result = cudaMemcpy((void*)c.data, (void*)d_c.data, d_a.n_x * sizeof(d_c.data[0]), cudaMemcpyDeviceToHost);
	assert(result == cudaSuccess);



	print_array(c);

        cudaFree(d_a.data); cudaFree(d_b.data); cudaFree(d_c.data);



	return 0;
}












































// template<typename T>
// struct matrix{

// 	int n_x;
// 	void* data;

	
// 	matrix(int nx){

// 		n_x = nx;
// 		data = (void*)malloc(nx*sizeof(T));

// 	}

// }
// ;

// template<typename T>
// __global__ void device_add(T *a, T *b, T *c) {

//         c[threadIdx.x] = a[threadIdx.x] + b[threadIdx.x];
// }



// template<typename T>
// void fill_array(matrix<T> &a) {
// 	T *ptr = (T*)a.data;
// 	for(int idx=0;idx<a.n_x;idx++)
// 		ptr[idx] = idx;
// }


// template<typename T>
// void print_array(matrix<T> &a )
// {
// T *ptr = (T*)a.data;
// for(int idx = 0; idx< a.n_x; idx++)
// 	std::cout<<ptr[idx]<<std::endl;


// }





// int main() {
// 		int N = 500;

// 		matrix<double> a(N);
// 		matrix<double> b(N);
// 		matrix<double> c(N);

// 		matrix<double> d_a(N);
// 		matrix<double> d_b(N);
// 		matrix<double> d_c(N);

// 		fill_array(a);
// 		fill_array(b);
// 		std::cout<<*((double*)a.data +5 )<<std::endl;

//         // Alloc space for device copies of a, b, c
//         cudaError_t result1 = cudaMalloc(&d_a.data, d_a.n_x * sizeof(double));
//         cudaError_t result2 = cudaMalloc(&d_b.data, d_b.n_x * sizeof(double));
//         cudaError_t result3 = cudaMalloc(&d_c.data, d_c.n_x * sizeof(double));
// 	assert(result1 == cudaSuccess || result2 == cudaSuccess || result3 == cudaSuccess);



//        // Copy inputs to device
//         result1 = cudaMemcpy(d_a.data, a.data, d_a.n_x * sizeof(double), cudaMemcpyHostToDevice);
//         result2 = cudaMemcpy(d_b.data, b.data, d_b.n_x * sizeof(double), cudaMemcpyHostToDevice);
// 	assert(result1 == cudaSuccess || result2 == cudaSuccess);

// 	device_add<<<1,N>>>((double*)d_a.data,(double*)d_b.data, (double*)d_c.data);  

//         // Copy result back to host
//         cudaError_t result = cudaMemcpy(c.data, d_c.data, d_a.n_x * sizeof(double), cudaMemcpyDeviceToHost);
// 	assert(result == cudaSuccess);



// 	print_array(c);

//         cudaFree(d_a.data); cudaFree(d_b.data); cudaFree(d_c.data);



// 	return 0;
// }

