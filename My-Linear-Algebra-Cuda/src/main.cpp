#include "Matrix/matrix.hpp"
#include<chrono>

int main() {
	Matrix<float> A = Matrix<float>(10000,10000,0.25,0.30);
	Matrix<float> B = Matrix<float>(10000,10000,0.25,0.30);
	Matrix<float> C = Matrix<float>(10000,10000);

	auto start = std::chrono::high_resolution_clock::now();
	
	
	C = A.add(B,true);
	
	auto end = std::chrono::high_resolution_clock::now();

	std::chrono::duration<double> duration = end - start;
    double elapsed_seconds = duration.count();

    // Print the elapsed time
    std::cout << "Elapsed time: " << elapsed_seconds << " seconds\n";


	return 0;
}
