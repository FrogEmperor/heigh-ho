#include <ctime>
#include <string>
#include <vector>
#include <iostream>

#include "block.hpp"
#include "blockchain.hpp"
#include "sha256.hpp"


Blockchain::Blockchain() {
    this->chain = std::vector<Block>();
    this->currentTransactions = std::vector<Transaction>();
    this->newBlock(100, "1");
}

Block Blockchain::newBlock(int proof, std::string previous) {
    int index = this->chain.size() + 1;
    int timestamp = std::time(0);
    std::vector<Transaction> transactions = this->currentTransactions;

    if(previous != "1") {
        previous = hash(this->lastBlock());
    }

    Block newBlock = Block(index, timestamp, transactions, proof, previous);

    this->currentTransactions = std::vector<Transaction>();
    this->chain.push_back(newBlock);
    
    return newBlock;
}

int Blockchain::newTransaction(std::string sender, std::string recipient, int amount) {
    Transaction newTransaction = Transaction(sender, recipient, amount);
    this->currentTransactions.push_back(newTransaction);
    return this->lastBlock().index + 1;
}

Block Blockchain::lastBlock() {
    return this->chain.back();
}

int Blockchain::proofOfWork(int lastProof) {
    int proof = 0;
    while(!validProof(lastProof, proof)) {
        if(proof % 100000 == 0) {
            std::cout << "Already reached " << proof << " attempts!" << std::endl;
        }
        proof += 1;
    }
    return proof;
}

std::string hash(Block block) {
    return sha256(block.serialize());
}

bool validProof(int lastProof, int currentProof) {
    std::string guess = std::to_string(lastProof) + std::to_string(currentProof);
    std::string guessHash = sha256(guess);
    std::string difficulty = guessHash.substr(0, 3);
    return difficulty == "0000";
}
