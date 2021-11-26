#include "sha256_gpu.cuh"

int main(){
    BYTE in[11];
    BYTE out[321]; 
    strcpy( (char*) in, "0123456789" );
    WORD inW = 10;
    WORD inO = 10;

    mcm_cuda_sha256_hash_batch(in, inW, out, inO);
    for(int i = 0; i < 330; i++){
        printf("%d:%d ",i,out[i]);
    }
    printf("\nMAMA");
}