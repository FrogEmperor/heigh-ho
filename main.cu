#include <iostream>
#include "blockchain.hpp"
#include "cuda_runtime.h"

__global__ void kernel(){

}

int main() {
    Blockchain btc = Blockchain(7);
    btc.newTransaction("oscar", "manolo", 1);
    btc.newTransaction("manolo", "dagz", 2);

    int lastProof = btc.lastBlock().proof;
    int newProof = btc.proofOfWork(lastProof);
    btc.newBlock(newProof, std::to_string(lastProof));
    kernel<<<1,1>>>();
    return 0;
}
