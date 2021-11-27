#pragma once
#include <stdint.h>
#include <string.h>
#include <stddef.h>

struct sha256_buff {
    uint64_t data_size;
    uint32_t h[8];
    uint8_t last_chunk[64];
    uint8_t chunk_size;
};

__device__ void sha256_init(struct sha256_buff* buff);

__device__ void sha256_update(struct sha256_buff* buff, const void* data, size_t size);

__device__ void sha256_finalize(struct sha256_buff* buff);

__device__ void sha256_read(const struct sha256_buff* buff, uint8_t* hash);

__device__ void sha256_read_hex(const struct sha256_buff* buff, char* hex);

__device__ void sha256_easy_hash(const void* data, size_t size, uint8_t* hash);

__device__ void sha256_easy_hash_hex(const void* data, size_t size, char* hex);
