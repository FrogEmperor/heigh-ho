#include <ctime>
#include <string>
#include <vector>
#include <iostream>

#include "block.hpp"
#include "blockchain.hpp"
#include "sha256.hpp"


Blockchain::Blockchain(int level) {
    this->chain = std::vector<Block>();
    this->currentTransactions = std::vector<Transaction>();
    this->newBlock(100, "1");
    this->level = level;
}

Block Blockchain::newBlock(int proof, std::string previous) {
    int index = this->chain.size() + 1;
    int timestamp = std::time(0);
    std::vector<Transaction> transactions = this->currentTransactions;

    if(previous != "1") {
        previous = this->lastBlock().hash();
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
        proof += 1;
        if(proof % 1000000 == 0) {
            std::cout << "Already reached " << proof << " attempts!" << std::endl;
        }
    }
    std::cout << "Proof: " << proof << std::endl;
    return proof;
}

bool Blockchain::validProof(int lastProof, int currentProof) {
    std::string guess = std::to_string(lastProof) + std::to_string(currentProof);
    std::string guessHash = sha256(guess);
    std::string sub = guessHash.substr(0, this->level);
    std::string zero = std::string(this->level, '0');

    return sub == zero;
}
