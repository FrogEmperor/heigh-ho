#include <ctime>
#include <string>
#include <vector>

#include "block.hpp"
#include "blockchain.hpp"
#include "sha256.hpp"


Blockchain::Blockchain() {
    this->chain = std::vector<Block>();
    this->currentTransactions = std::vector<Transaction>();
}

Block Blockchain::newBlock(int proof) {
    int index = this->chain.size() + 1;
    int timestamp = std::time(0);
    std::vector<Transaction> transactions = this->currentTransactions;
    std::string previous = hash(this->lastBlock());

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

std::string hash(Block block) {
    return sha256(block.serialize());
}
