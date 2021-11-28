#include "sha256_gpu.cuh"
#include "proof.cuh"
#include <cuda.h>
#include <stdio.h>

__global__ void kernel(long long int* buffer, long long int lastProof, long long int currentProof, long long int level){
    long long int i = blockIdx.x * blockDim.x + threadIdx.x;
    if(validProof(lastProof, i+currentProof, level)==1)
        *buffer = i+currentProof;
}

__host__ void callKernel(long long int* d_buffer, long long int* h_buffer, long long int lastProof, long long int level){
    long long int count = 0;
    long long int t = 128;
    long long int b = 4097 / t + 1;
    printf("%lld\n", *h_buffer);
    while(*h_buffer == 0) 
    {
        kernel<<<b,t>>>(d_buffer, lastProof, count * t * b, level);
        cudaMemcpy(h_buffer, d_buffer, sizeof(int*), cudaMemcpyDeviceToHost);
        count++;
        if(count % 300 == 0)
            printf("%lld\n", count);
    }
    printf("%lld\n", count);
}

int main(){
    long long int lastProof= 1324;
    long long int level = 6;
    long long int* h_buffer = (long long int*)malloc(sizeof(long long int*));
    long long int* d_buffer;
    *h_buffer=0;
    cudaMalloc((void**)&d_buffer, sizeof(long long int*));
    callKernel(d_buffer, h_buffer, lastProof, level);

    printf("%lld",*h_buffer);
}