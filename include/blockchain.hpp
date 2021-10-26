#pragma once

#include <vector>
#include <string>

#include "block.hpp"


struct Blockchain {
    std::vector<Block> chain;
    std::vector<Transaction> currentTransactions;

    Blockchain();

    Block newBlock(int proof);
    int newTransaction(std::string sender, std::string recipient, int amount);
    Block lastBlock();

};

std::string hash(Block block);

std::string serialize(Block block);
