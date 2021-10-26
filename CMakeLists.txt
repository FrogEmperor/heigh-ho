cmake_minimum_required(VERSION 3.0)

project(BIGCASHMONEY VERSION 0.1 LANGUAGES CXX)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_STANDARD 17)

include_directories(include)

add_executable(cash main.cpp src/block.cpp src/blockchain.cpp src/sha256.cpp)