#include <iostream>
#include "blockchain.hpp"

int main() {
    Blockchain btc = Blockchain(6);
    btc.newTransaction("oscar", "manolo", 1);
    btc.newTransaction("manolo", "dagz", 2);

    int lastProof = btc.lastBlock().proof;
    int newProof = btc.proofOfWork(lastProof);
    btc.newBlock(newProof, std::to_string(lastProof));
    return 0;
}
