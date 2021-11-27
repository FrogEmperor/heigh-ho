#include "sha256_gpu.cuh"
#include "proof.cuh"
#include <cuda.h>
#include <stdio.h>

__global__ void kernel(int* buffer){
    *buffer = proofOfWork(12345,2);
}


int main(){
    int h_buffer[1];
    int* d_buffer;
    cudaMalloc((void**)&d_buffer, sizeof(int));
    kernel<<<1,1>>>(d_buffer);
    cudaMemcpy(h_buffer, d_buffer, sizeof(int), cudaMemcpyDeviceToHost);
    printf("%d",*h_buffer);
}