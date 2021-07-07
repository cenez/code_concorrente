/* 
 * https://cuda-tutorial.readthedocs.io/en/latest/tutorials/tutorial01/
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

#define MAX_ERR 1e-6

void verify(float *out, float *a, float *b, int n) {
    for(int i = 0; i < n; i++){
        assert(fabs(out[i] - a[i] - b[i]) < MAX_ERR);
    }
    printf("out[0] = %f\n", out[0]);
    printf("OK\n");
}

__global__ void vector_add(float *out, float *a, float *b, int n) {
    for(int i = 0; i < n; i++){
        out[i] = a[i] + b[i];
    }
}

int main(int argc, char *argv[]){
	if(argc<2) return 0;
	long N = atol(argv[1]);
    float *a, *b, *out; float *d_a, *d_b, *d_out;
    
	a   = (float*)malloc(sizeof(float) * N);
    b   = (float*)malloc(sizeof(float) * N);
    out = (float*)malloc(sizeof(float) * N);
	
	cudaMalloc((void**)&d_a, sizeof(float) * N);
    cudaMalloc((void**)&d_b, sizeof(float) * N);
    cudaMalloc((void**)&d_out, sizeof(float) * N);

    for(int i = 0; i < N; i++){ a[i] = i; b[i] = i; }

    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);
	
	vector_add<<<1,1>>>(d_out, d_a, d_b, N);
	cudaMemcpy(out, d_out, sizeof(float) * N, cudaMemcpyDeviceToHost);
	
	//for(int i = 0; i < N; i++){
    //    printf("%.2f ", out[i]);
    //} printf("\n");
	
	verify(out, a, b, N);

	cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_out);
	free(a);
    free(b);
    free(out);
}

