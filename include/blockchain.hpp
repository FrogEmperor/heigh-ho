#pragma once

#include <vector>
#include <string>

#include "block.hpp"


struct Blockchain {
    std::vector<Block> chain;
    std::vector<Transaction> currentTransactions;

    Blockchain();

    Block lastBlock();
    Block newBlock(int proof, std::string previous);
    int newTransaction(std::string sender, std::string recipient, int amount);
    int proofOfWork(int lastProof);
};

std::string hash(Block block);

std::string serialize(Block block);

bool validProof(int lastProof, int currentProof);
