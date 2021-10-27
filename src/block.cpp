#include "block.hpp"
#include "sha256.hpp"


Transaction::Transaction(std::string sender, std::string recipient, int amount) {
    this->amount = amount;
    this->recipient = recipient;
    this->sender = sender;
}

Block::Block(int index, int timestamp, std::vector<Transaction> transactions, int proof, std::string previousHash) {
    this->index = index;
    this->timestamp = timestamp;
    this->transactions = transactions;
    this->proof = proof;
    this->previousHash = previousHash;
}

std::string Block::serialize() {
    std::string result = this->previousHash + std::to_string(this->index) + std::to_string(this->timestamp) + std::to_string(this->proof);
    for(auto trans: this->transactions) {
        result += std::to_string(trans.amount) + trans.recipient + trans.sender;
    }
    return result;
}

std::string Block::hash() {
    return sha256(this->serialize());
}