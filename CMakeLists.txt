cmake_minimum_required(VERSION 3.18)

project(BIGCASHMONEY VERSION 0.1 LANGUAGES CUDA CXX)

string(APPEND CMAKE_CUDA_FLAGS " -dc -gencode=arch=compute_75,code=sm_75")

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CUDA_IMPLICIT_LINK_LIBRARIES "cudadevrt.lib;cudart_static.lib")

include_directories(include)

add_library(miner STATIC 
    src/block.cpp 
    src/blockchain.cpp 
    src/sha256.cpp
)
add_library(miner_gpu STATIC 
    src/sha256_gpu.cu
    src/proof.cu
)

add_executable(cash main.cpp)
add_executable(cash_gpu main.cu)

set_property(TARGET cash_gpu PROPERTY CUDA_SEPARABLE_COMPILATION ON)
set_target_properties(cash_gpu PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
set_target_properties(cash_gpu PROPERTIES CUDA_RESOLVE_DEVICE_SYMBOLS ON)

target_link_libraries(cash PRIVATE miner)
target_link_libraries(cash_gpu PRIVATE miner_gpu)
