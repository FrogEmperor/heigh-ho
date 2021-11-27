#pragma once

__device__ int stringSize(char* string);

__device__ void swap(char *x, char *y);
 
__device__ char* reverse(char *buffer, int i, int j);

__device__ int digitCount(int value);

__device__ char* itoa(int value);

__device__ char* joinStrings(char* first, char* second);

__device__ char* substring(char* string, int len);

__device__ char* repeatChar(char c, int len);

__device__ int compareStrings(char* first, char* second);

__device__ int validProof(int lastProof, int currentProof, int level);

__device__ int proofOfWork(int lastProof, int level);