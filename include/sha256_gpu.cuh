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

/* Initialization, must be called before any further use */
__device__ void sha256_init(struct sha256_buff* buff);

/* Process block of data of arbitary length, can be used on data streams (files, etc) */
__device__ void sha256_update(struct sha256_buff* buff, const void* data, size_t size);

/* Produces final hash values (digest) to be read
   If the buffer is reused later, init must be called again */
__device__ void sha256_finalize(struct sha256_buff* buff);

/* Read digest into 32-byte binary array */
__device__ void sha256_read(const struct sha256_buff* buff, uint8_t* hash);

/* Read digest into 64-char string as hex (without null-byte) */
__device__ void sha256_read_hex(const struct sha256_buff* buff, char* hex);

/* Hashes single contiguous block of data and reads digest into 32-byte binary array */
__device__ void sha256_easy_hash(const void* data, size_t size, uint8_t* hash);

/* Hashes single contiguous block of data and reads digest into 64-char string (without null-byte) */
__device__ void sha256_easy_hash_hex(const void* data, size_t size, char* hex);

__device__ void mama();