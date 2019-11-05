| Instruction                | LLVM[1]                   | V8[2]                 | WAVM[3]            | ChakraCore[4]      |
| ---------------------------|---------------------------|-----------------------|--------------------|--------------------|
| `v128.load`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v128.store`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v128.const`               | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.splat`              |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v8x16.load_splat`         | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i8x16.extract_lane_s`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.extract_lane_u`     | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.replace_lane`       |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.splat`              |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v16x8.load_splat`         | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i16x8.extract_lane_s`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.extract_lane_u`     | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.replace_lane`       |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.splat`              |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v32x4.load_splat`         | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i32x4.extract_lane`       |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.replace_lane`       |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.splat`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.extract_lane`       | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.replace_lane`       | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.splat`              |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.extract_lane`       |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.replace_lane`       |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.splat`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `v64x2.load_splat`         | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `f64x2.extract_lane`       | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.replace_lane`       | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.eq`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.ne`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.lt_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.lt_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.gt_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.gt_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.le_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.le_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.ge_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.ge_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.eq`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.ne`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.lt_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.lt_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.gt_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.gt_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.le_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.le_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.ge_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.ge_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.eq`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.ne`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.lt_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.lt_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.gt_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.gt_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.le_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.le_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.ge_s`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.ge_u`               |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.eq`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.ne`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.lt`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.gt`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.le`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.ge`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.eq`                 | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.ne`                 | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.lt`                 | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.gt`                 | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.le`                 | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.ge`                 | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `v128.not`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v128.and`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v128.andnot`              | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `v128.or`                  |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v128.xor`                 |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `v128.bitselect`           |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.neg`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.any_true`           |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.all_true`           |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.shl`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.shr_s`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.shr_u`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.add`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.add_saturate_s`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.add_saturate_u`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.sub`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.sub_saturate_s`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.sub_saturate_u`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.min_s`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i8x16.min_u`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i8x16.max_s`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i8x16.max_u`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i16x8.neg`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.any_true`           |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.all_true`           |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.shl`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.shr_s`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.shr_u`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.add`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.add_saturate_s`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.add_saturate_u`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.sub`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.sub_saturate_s`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.sub_saturate_u`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.mul`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.min_s`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i16x8.min_u`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i16x8.max_s`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i16x8.max_u`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i32x4.neg`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.any_true`           |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.all_true`           |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.shl`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.shr_s`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.shr_u`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.add`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.sub`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.mul`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.min_s`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i32x4.min_u`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i32x4.max_s`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i32x4.max_u`              | `-munimplemented-simd128` |    :heavy_check_mark: |                    |                    |
| `i64x2.neg`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.shl`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.shr_s`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.shr_u`              | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.add`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.sub`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.mul`                |                           |                       | :heavy_check_mark: |                    |
| `f32x4.abs`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.neg`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.sqrt`               | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.add`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.sub`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.mul`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.div`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.min`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.max`                |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.abs`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.neg`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.sqrt`               | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.add`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.sub`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.mul`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.div`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.min`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.max`                | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.trunc_sat_f32x4_s`  |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.trunc_sat_f32x4_u`  |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.trunc_sat_f64x2_s`  | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.trunc_sat_f64x2_u`  | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.convert_i32x4_s`    |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.convert_i32x4_u`    |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.convert_i64x2_s`    | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.convert_i64x2_u`    | `-munimplemented-simd128` |                       | :heavy_check_mark: | :heavy_check_mark: |
| `v8x16.swizzle`            |                           |                       | :heavy_check_mark: |                    |
| `v8x16.shuffle`            |            `-msimd128`[5] | :white_check_mark:[5] | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.load8x8_s`          | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i16x8.load8x8_u`          | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i32x4.load16x4_s`         | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i32x4.load16x4_u`         | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i64x2.load32x2_s`         | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i64x2.load32x2_u`         | `-munimplemented-simd128` |                       | :heavy_check_mark: |                    |
| `i8x16.narrow_i16x8_s`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i8x16.narrow_i16x8_u`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i16x8.narrow_i32x4_s`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i16x8.narrow_i32x4_u`     |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i16x8.widen_low_i8x16_s`  |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i16x8.widen_high_i8x16_s` |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i16x8.widen_low_i8x16_u`  |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i16x8.widen_high_i8x16_u` |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i32x4.widen_low_i16x8_s`  |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i32x4.widen_high_i16x8_s` |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i32x4.widen_low_i16x8_u`  |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |
| `i32x4.widen_high_i16x8_u` |               `-msimd128` |    :heavy_check_mark: | :heavy_check_mark: |                    |

[1] Tip of tree LLVM as of September 30, 2019

[2] Tested on V8 7.5.0 (candidate). Requires flag `--experimental-wasm-simd`

[3] Tip of tree WAVM as of Oct 23, 2019. Requires flag `--enable simd`

[4] Requires (case-insensitive) flag `-wasmsimd`

[5] Uses older `v8x16.shuffle` opcode `0xfd 0x03`
