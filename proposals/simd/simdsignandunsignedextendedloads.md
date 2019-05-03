### **Proposal WebAssembly SIMD Modification**

Currently as proposed there is an instructions defined in the WASM SIMD ISA as follows.

**i8x16.mul** which is a register to register operation that takes 16 8 bit integers and

multiplies them together resulting in an 8 bit value. If the distribution of the integers it flat this

would result in a large percent of the instructions with overflow. This is a problem for many applications.


### Proposed new instructions

Six new load instructions are being proposed to make integer multiplies easier. i8x16zxload, i8x16sxload, i16x8zxload, i16x8sxload, i32x4zxload, i32x4sxload. This would make i8, i16, i32 multiplies useful and more practical for applications such as machine learning, image compression and video and rendering data processing.The new instructions would take consecutive integers of the corresponding size and zero sign extend and sign extend the consecutive bytes, words or dword to the promoted size of signed or unsigned data. An example of zero sign extend is shown below:  Intel and ARM both have this capability by doing the following:

Intel Instructions:



*   movzxbw
*   movzxwd
*   movzxdq
*   movsxbw
*   movsxwd
*   Movsxdq

ARM Instructions:



*   LDR X0, [X1] Load from the address in X1
*   LDR X0, [X1, #8] Load from address X1 + 8
*   LDR X0, [X1, X2] Load from address X1 + X2
*   LDR X0, [X1, X2, LSL, #3] Load from address X1 + (X2 << 3)
*   LDR X0, [X1, W2, SXTW] Load from address X1 + sign extend(W2)
*   LDR X0, [X1, W2, SXTW, #3] Load from address X1 + (sign extend(W2) << 3)

So the new instructions for WASM would be defined as follows:



*   i8x8.zxload
*   i16x4.zxload
*   i32x2.zxload
*   i8x8.sxload
*   i16x4.sxload
*   i32x2.sxload

As a result of these new instructions a multiply can now be done without worrying about signed

and unsigned overflow on the data it operates on.

The following is a partial sample example of how sign extended loads are be used in a matrix multiply of 8 bit integers:


```
       "pmovzxbw 0x00(%[mem]), %%xmm0\n\t"
       "pshufd $0x00,%%xmm1,%%xmm2     \n\t"
       "pshufd $0x55,%%xmm1,%%xmm3     \n\t"
       "pmaddwd %%xmm0, %%xmm2         \n\t"
       "pmaddwd %%xmm0, %%xmm3         \n\t"
       "paddd %%xmm2, %%xmm4           \n\t"
       "paddd %%xmm3, %%xmm5           \n\t"

