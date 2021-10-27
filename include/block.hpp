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
    std::string previousHash;
    std::vector<Transaction> transactions;

    Block(int index, int timestamp, std::vector<Transaction> transactions, int proof, std::string previousHash);

    std::string serialize();
    std::string hash();
};
