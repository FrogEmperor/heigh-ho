#include "sha256_gpu.cuh"
#include <cuda.h>
#include <stdio.h>

__global__ void kernel(char* buffer){
    char* string = {"abc"};
    int count = 0;
    while(string[count] != 0)
        count++;
    sha256_easy_hash_hex(string, count,buffer);
}

int main(){
    char* h_buffer[65] = {0};
    char* d_buffer;
    cudaMalloc((void**)&d_buffer, sizeof(char) * 65);
    kernel<<<1,1>>>(d_buffer);
    cudaMemcpy(h_buffer, d_buffer, sizeof(char)*65, cudaMemcpyDeviceToHost);
    printf("%s",h_buffer);
}