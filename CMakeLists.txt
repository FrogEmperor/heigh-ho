cmake_minimum_required(VERSION 3.0)

project(BIGCASHMONEY VERSION 0.1 LANGUAGES CXX CUDA)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_STANDARD 11)

include_directories(include)

add_library(miner STATIC 
    src/block.cpp 
    src/blockchain.cpp 
    src/sha256.cpp
)
add_library(miner_gpu STATIC src/sha256_gpu.cu)

add_executable(cash main.cpp)
add_executable(cash_gpu main.cu)

set_target_properties(cash_gpu PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

target_link_libraries(cash PRIVATE miner)
target_link_libraries(cash_gpu PRIVATE miner_gpu)