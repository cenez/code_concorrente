#!/bin/sh

N=10000000

gcc vector_add.c -o a
echo "***************************** HOST *****************************"
time ./a $N

nvcc vector_add.cu -o a
echo "***************************** DISPOSITIVO (GPU) *****************************"
time ./a $N


