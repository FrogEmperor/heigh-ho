cmake_minimum_required(VERSION 3.0)

project(BIGCASHMONEY VERSION 0.1 LANGUAGES CXX CUDA)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_STANDARD 11)

include_directories(include)

add_library(miner STATIC 
    src/block.cpp 
    src/blockchain.cpp 
    src/sha256.cpp
    src/miner.cu
)

add_executable(cash main.cu)

set_target_properties(cash PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

target_link_libraries(cash PRIVATE miner)