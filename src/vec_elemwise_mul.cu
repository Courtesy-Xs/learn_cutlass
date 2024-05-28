// error: identifier "CUTE_STL_NAMESPACE" is undefined, I suspect it’s a cutlass issue
// #include "cute/numeric/int.hpp"

#include <cute/tensor.hpp>
#include <cuda_fp16.h>
#include <cstdlib>
#include <cmath>


using namespace cute;

// Vector Add
// z = ax + by + c
template <int kNumElemPerThread = 8>
__global__ void vector_add_local_tile_multi_elem_per_thread_half(
    half *z, int num, const half *x, const half *y, const half a, const half b, const half c) {
  using namespace cute;

  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  if (idx >= num / kNumElemPerThread) { // 未处理非对齐问题
    return;
  }

  Tensor tz = make_tensor(make_gmem_ptr(z), make_shape(num));
  Tensor tx = make_tensor(make_gmem_ptr(x), make_shape(num));
  Tensor ty = make_tensor(make_gmem_ptr(y), make_shape(num));

  Tensor tzr = local_tile(tz, make_shape(Int<kNumElemPerThread>{}), make_coord(idx));
  Tensor txr = local_tile(tx, make_shape(Int<kNumElemPerThread>{}), make_coord(idx));
  Tensor tyr = local_tile(ty, make_shape(Int<kNumElemPerThread>{}), make_coord(idx));

  Tensor txR = make_tensor_like(txr);
  Tensor tyR = make_tensor_like(tyr);
  Tensor tzR = make_tensor_like(tzr);

  // LDG.128
  copy(txr, txR);
  copy(tyr, tyR);

  half2 a2 = {a, a};
  half2 b2 = {b, b};
  half2 c2 = {c, c};

  auto tzR2 = recast<half2>(tzR);
  auto txR2 = recast<half2>(txR);
  auto tyR2 = recast<half2>(tyR);

#pragma unroll
  for (int i = 0; i < size(tzR2); ++i) {
    // two hfma2 instruction
    tzR2(i) = txR2(i) * a2 + (tyR2(i) * b2 + c2);
  }

  auto tzRx = recast<half>(tzR2);

  // STG.128
  copy(tzRx, tzr);
}

int main()
{
  const int kNumel = 1024;
  half *hx, *hy, *hz, *dx, *dy, *dz;

  half a = 1.0;
  half b = 1.0;
  half c = 1.0;

  cudaMalloc((void**)(&dx), sizeof(half) * kNumel);
  cudaMalloc((void**)(&dy), sizeof(half) * kNumel);
  cudaMalloc((void**)(&dz), sizeof(half) * kNumel);

  cudaMemset(dx, 0, sizeof(half) * kNumel);
  cudaMemset(dy, 0, sizeof(half) * kNumel);
  cudaMemset(dz, 0, sizeof(half) * kNumel);

  hx = (half*)(malloc(kNumel * sizeof(half)));
  hy = (half*)(malloc(kNumel * sizeof(half)));  
  hz = (half*)(malloc(kNumel * sizeof(half)));

  std::for_each(hx, hx + kNumel, [](half& ele){ ele = 1.0; });
  std::for_each(hy, hy + kNumel, [](half& ele){ ele = 1.0; });

  cudaMemcpy(dx, hx, sizeof(half) * kNumel, cudaMemcpyHostToDevice);
  cudaMemcpy(dy, hy, sizeof(half) * kNumel, cudaMemcpyHostToDevice);

  dim3 grid(1);
  dim3 block(256);

  vector_add_local_tile_multi_elem_per_thread_half<4><<<grid, block, 0, 0>>>(dz, kNumel, dx, dy, a, b, c);

  cudaDeviceSynchronize();

  cudaMemcpy(hz, dz, sizeof(half) * kNumel, cudaMemcpyDeviceToHost);

  // verify
  std::for_each(hz, hz + kNumel, [](half val){ if(std::fabs(static_cast<float>(val)) - 3.0f > 1e-7) { std::cout << static_cast<float>(val) << "\t";} });

  // output
  // std::for_each(hz, hz + kNumel, [](half val){ std::cout << static_cast<float>(val) << "\t";});

  return 0;
}