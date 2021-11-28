#include "proof.cuh"
#include "sha256_gpu.cuh"

__device__ int stringSize(char* string){
    int size = 0;
    while(string[size] != 0)
        size++;
    return size;
}

void swap(char *x, char *y) {
    char t = *x; *x = *y; *y = t;
}
 
char* reverse(char *buffer, int i, int j)
{
    while (i < j) {
        swap(&buffer[i++], &buffer[j--]);
    }
 
    return buffer;
}

__device__ int digitCount(int n){
    int count = 0;
    
    do {
        n /= 10;
        ++count;
    } while (n != 0);
    
    return count;
}

__device__ char* itoa(int value){
    char* buffer = (char*)malloc(digitCount(value) * sizeof(char));
    int base = 10;
 
    int n = abs(value);
 
    int i = 0;
    while (n)
    {
        int r = n % base;
 
        if (r >= 10) {
            buffer[i++] = 65 + (r - 10);
        }
        else {
            buffer[i++] = 48 + r;
        }
 
        n = n / base;
    }
 
    if (i == 0) {
        buffer[i++] = '0';
    }
 
    if (value < 0 && base == 10) {
        buffer[i++] = '-';
    }
 
    buffer[i] = '\0'; // null terminate string
 
    return reverse(buffer, 0, i - 1);
}

__device__ char* joinStrings(char* first, char* second){
    int firstSize = stringSize(first); 
    int secondSize = stringSize(second);
    int totalSize = firstSize + secondSize;
    char* result = (char*)malloc((totalSize + 1) * sizeof(char));
    for(int i = 0; i < firstSize; i++)
        result[i] = first[i];
    for(int i = 0; i < secondSize; i++)
        result[firstSize + i] = second[i];
    result[totalSize] = 0;
    return result;
}

__device__ char* substring(char* string, int len){
    char* result = (char*)malloc((len+1) * sizeof(char));
    for(int i = 0; i < len; i++)
        result[i] = string[i];
    result[len] = 0;
    return result;
}

__device__ char* repeatChar(char c, int len){
    char* result = (char*)malloc((len+1)*sizeof(char));
    for(int i = 0; i < len; i++)
        result[i] = c;
    result[len] = 0;
    return result;
}

__device__ int compareStrings(char* first, char* second, int len){
    for(int i = 0; i < len; i++)
        if(first[i] != second[i])
            return 0;
    return 1;
}

__device__ int validProof(int lastProof, int currentProof, int level){
    char* lastProofChar = itoa(lastProof);
    char* currentProofChar = itoa(currentProof);
    char* guess = joinStrings(lastProofChar, currentProofChar);
    free(lastProofChar); 
    free(currentProofChar);
    char guessHash[65] = {0};
    sha256_easy_hash_hex(guess, stringSize(guess), guessHash);
    free(guess);
    char* sub = substring(guessHash, level);
    char* zero = repeatChar('0', level);
    int result = compareStrings(sub, zero, level);
    free(sub);
    free(zero);
    return result;
}

__device__ int proofOfWork(int lastProof, int level){
    int proof = 0;
    while(!validProof(lastProof, proof, level)) {
        proof += 1;
    }
    return proof;
}