#pragma once

#include <vector>
#include <string>


struct Transaction {
    int amount;
    std::string sender;
    std::string recipient;
    
    Transaction(std::string sender, std::string recipient, int amount);
};

struct Block { 
    int index;
    int proof;
    int timestamp;
    std::vector<Transaction> transactions;
    std::string previousHash;

    Block(int index, int timestamp, std::vector<Transaction> transactions, int proof, std::string previousHash);

    std::string serialize();
};
