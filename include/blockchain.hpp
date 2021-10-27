#pragma once

#include <vector>
#include <string>

#include "block.hpp"


struct Blockchain {
    int level;
    std::vector<Block> chain;
    std::vector<Transaction> currentTransactions;

    Blockchain(int level);

    Block lastBlock();
    Block newBlock(int proof, std::string previous);
    int newTransaction(std::string sender, std::string recipient, int amount);
    int proofOfWork(int lastProof);
    bool validProof(int lastProof, int currentProof);
};
