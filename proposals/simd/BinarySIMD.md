# Binary encoding of SIMD

This document describes the binary encoding of the SIMD value type and
instructions.

## SIMD value type

The `v128` value type is encoded as 0x7b:

```
valtype ::= ...
          | 0x7B => v128
```

## SIMD instruction encodings

All SIMD instructions are encoded as a 0xfd prefix byte followed by a
SIMD-specific opcode in LEB128 format:

```
instr ::= ...
        | 0xFD simdop:varuint32 ...
```

Some SIMD instructions have additional immediate operands following `simdop`.
The `v8x16.shuffle` instruction has 16 bytes after `simdop`.

| Instruction               | `simdop` | Immediate operands |
| --------------------------|---------:|--------------------|
| `v128.const`              |    `0x00`| i:ImmByte[16]      |
| `v128.load`               |    `0x01`| m:memarg           |
| `v128.store`              |    `0x02`| m:memarg           |
| `i8x16.splat`             |    `0x03`| -                  |
| `i16x8.splat`             |    `0x04`| -                  |
| `i32x4.splat`             |    `0x05`| -                  |
| `i64x2.splat`             |    `0x06`| -                  |
| `f32x4.splat`             |    `0x07`| -                  |
| `f64x2.splat`             |    `0x08`| -                  |
| `i8x16.extract_lane_s`    |    `0x09`| i:LaneIdx16        |
| `i8x16.extract_lane_u`    |    `0x0a`| i:LaneIdx16        |
| `i16x8.extract_lane_s`    |    `0x0b`| i:LaneIdx8         |
| `i16x8.extract_lane_u`    |    `0x0c`| i:LaneIdx8         |
| `i32x4.extract_lane`      |    `0x0d`| i:LaneIdx4         |
| `i64x2.extract_lane`      |    `0x0e`| i:LaneIdx2         |
| `f32x4.extract_lane`      |    `0x0f`| i:LaneIdx4         |
| `f64x2.extract_lane`      |    `0x10`| i:LaneIdx2         |
| `i8x16.replace_lane`      |    `0x11`| i:LaneIdx16        |
| `i16x8.replace_lane`      |    `0x12`| i:LaneIdx8         |
| `i32x4.replace_lane`      |    `0x13`| i:LaneIdx4         |
| `i64x2.replace_lane`      |    `0x14`| i:LaneIdx2         |
| `f32x4.replace_lane`      |    `0x15`| i:LaneIdx4         |
| `f64x2.replace_lane`      |    `0x16`| i:LaneIdx2         |
| `v8x16.shuffle`           |    `0x17`| s:LaneIdx32[16]    |
| `i8x16.add`               |    `0x18`| -                  |
| `i16x8.add`               |    `0x19`| -                  |
| `i32x4.add`               |    `0x1a`| -                  |
| `i64x2.add`               |    `0x1b`| -                  |
| `i8x16.sub`               |    `0x1c`| -                  |
| `i16x8.sub`               |    `0x1d`| -                  |
| `i32x4.sub`               |    `0x1e`| -                  |
| `i64x2.sub`               |    `0x1f`| -                  |
| `i8x16.mul`               |    `0x20`| -                  |
| `i16x8.mul`               |    `0x21`| -                  |
| `i32x4.mul`               |    `0x22`| -                  |
| `i8x16.neg`               |    `0x24`| -                  |
| `i16x8.neg`               |    `0x25`| -                  |
| `i32x4.neg`               |    `0x26`| -                  |
| `i64x2.neg`               |    `0x27`| -                  |
| `i8x16.add_saturate_s`    |    `0x28`| -                  |
| `i8x16.add_saturate_u`    |    `0x29`| -                  |
| `i16x8.add_saturate_s`    |    `0x2a`| -                  |
| `i16x8.add_saturate_u`    |    `0x2b`| -                  |
| `i8x16.sub_saturate_s`    |    `0x2c`| -                  |
| `i8x16.sub_saturate_u`    |    `0x2d`| -                  |
| `i16x8.sub_saturate_s`    |    `0x2e`| -                  |
| `i16x8.sub_saturate_u`    |    `0x2f`| -                  |
| `i8x16.shl`               |    `0x30`| -                  |
| `i16x8.shl`               |    `0x31`| -                  |
| `i32x4.shl`               |    `0x32`| -                  |
| `i64x2.shl`               |    `0x33`| -                  |
| `i8x16.shr_s`             |    `0x34`| -                  |
| `i8x16.shr_u`             |    `0x35`| -                  |
| `i16x8.shr_s`             |    `0x36`| -                  |
| `i16x8.shr_u`             |    `0x37`| -                  |
| `i32x4.shr_s`             |    `0x38`| -                  |
| `i32x4.shr_u`             |    `0x39`| -                  |
| `i64x2.shr_s`             |    `0x3a`| -                  |
| `i64x2.shr_u`             |    `0x3b`| -                  |
| `v128.and`                |    `0x3c`| -                  |
| `v128.or`                 |    `0x3d`| -                  |
| `v128.xor`                |    `0x3e`| -                  |
| `v128.not`                |    `0x3f`| -                  |
| `v128.bitselect`          |    `0x40`| -                  |
| `i8x16.any_true`          |    `0x41`| -                  |
| `i16x8.any_true`          |    `0x42`| -                  |
| `i32x4.any_true`          |    `0x43`| -                  |
| `i64x2.any_true`          |    `0x44`| -                  |
| `i8x16.all_true`          |    `0x45`| -                  |
| `i16x8.all_true`          |    `0x46`| -                  |
| `i32x4.all_true`          |    `0x47`| -                  |
| `i64x2.all_true`          |    `0x48`| -                  |
| `i8x16.eq`                |    `0x49`| -                  |
| `i16x8.eq`                |    `0x4a`| -                  |
| `i32x4.eq`                |    `0x4c`| -                  |
| `f32x4.eq`                |    `0x4d`| -                  |
| `f64x2.eq`                |    `0x4e`| -                  |
| `i8x16.ne`                |    `0x4f`| -                  |
| `i16x8.ne`                |    `0x50`| -                  |
| `i32x4.ne`                |    `0x51`| -                  |
| `f32x4.ne`                |    `0x53`| -                  |
| `f64x2.ne`                |    `0x54`| -                  |
| `i8x16.lt_s`              |    `0x55`| -                  |
| `i8x16.lt_u`              |    `0x56`| -                  |
| `i16x8.lt_s`              |    `0x57`| -                  |
| `i16x8.lt_u`              |    `0x58`| -                  |
| `i32x4.lt_s`              |    `0x59`| -                  |
| `i32x4.lt_u`              |    `0x5a`| -                  |
| `f32x4.lt`                |    `0x5d`| -                  |
| `f64x2.lt`                |    `0x5e`| -                  |
| `i8x16.le_s`              |    `0x5f`| -                  |
| `i8x16.le_u`              |    `0x60`| -                  |
| `i16x8.le_s`              |    `0x61`| -                  |
| `i16x8.le_u`              |    `0x62`| -                  |
| `i32x4.le_s`              |    `0x63`| -                  |
| `i32x4.le_u`              |    `0x64`| -                  |
| `f32x4.le`                |    `0x67`| -                  |
| `f64x2.le`                |    `0x68`| -                  |
| `i8x16.gt_s`              |    `0x69`| -                  |
| `i8x16.gt_u`              |    `0x6a`| -                  |
| `i16x8.gt_s`              |    `0x6b`| -                  |
| `i16x8.gt_u`              |    `0x6c`| -                  |
| `i32x4.gt_s`              |    `0x6d`| -                  |
| `i32x4.gt_u`              |    `0x6e`| -                  |
| `f32x4.gt`                |    `0x71`| -                  |
| `f64x2.gt`                |    `0x72`| -                  |
| `i8x16.ge_s`              |    `0x73`| -                  |
| `i8x16.ge_u`              |    `0x74`| -                  |
| `i16x8.ge_s`              |    `0x75`| -                  |
| `i16x8.ge_u`              |    `0x76`| -                  |
| `i32x4.ge_s`              |    `0x77`| -                  |
| `i32x4.ge_u`              |    `0x78`| -                  |
| `f32x4.ge`                |    `0x7b`| -                  |
| `f64x2.ge`                |    `0x7c`| -                  |
| `f32x4.neg`               |    `0x7d`| -                  |
| `f64x2.neg`               |    `0x7e`| -                  |
| `f32x4.abs`               |    `0x7f`| -                  |
| `f64x2.abs`               |    `0x80`| -                  |
| `f32x4.min`               |    `0x87`| -                  |
| `f64x2.min`               |    `0x88`| -                  |
| `f32x4.max`               |    `0x8f`| -                  |
| `f64x2.max`               |    `0x90`| -                  |
| `f32x4.add`               |    `0x91`| -                  |
| `f64x2.add`               |    `0x92`| -                  |
| `f32x4.sub`               |    `0x93`| -                  |
| `f64x2.sub`               |    `0x94`| -                  |
| `f32x4.div`               |    `0x95`| -                  |
| `f64x2.div`               |    `0x96`| -                  |
| `f32x4.mul`               |    `0x97`| -                  |
| `f64x2.mul`               |    `0x98`| -                  |
| `f32x4.sqrt`              |    `0x99`| -                  |
| `f64x2.sqrt`              |    `0x9a`| -                  |
| `f32x4.convert_s/i32x4`   |    `0x9b`| -                  |
| `f32x4.convert_u/i32x4`   |    `0x9c`| -                  |
| `f64x2.convert_s/i64x2`   |    `0x9d`| -                  |
| `f64x2.convert_u/i64x2`   |    `0x9e`| -                  |
| `i32x4.trunc_s/f32x4:sat` |    `0x9f`| -                  |
| `i32x4.trunc_u/f32x4:sat` |    `0xa0`| -                  |
| `i64x2.trunc_s/f64x2:sat` |    `0xa1`| -                  |
| `i64x2.trunc_u/f64x2:sat` |    `0xa2`| -                  |
