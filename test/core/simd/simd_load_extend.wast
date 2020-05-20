;; Load and Extend test cases

(module
  (memory 1)
  (data (i32.const 0) "\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\80\81\82\83\84\85\86\87\88\89")
  (data (i32.const 65520) "\0A\0B\0C\0D\0E\0F\80\81\82\83\84\85\86\87\88\89")

  (func (export "i16x8.load8x8_s") (param $0 i32) (result v128)
    (i16x8.load8x8_s (local.get $0))
  )
  (func (export "i16x8.load8x8_u") (param $0 i32) (result v128)
    (i16x8.load8x8_u (local.get $0))
  )
  (func (export "i32x4.load16x4_s") (param $0 i32) (result v128)
    (i32x4.load16x4_s (local.get $0))
  )
  (func (export "i32x4.load16x4_u") (param $0 i32) (result v128)
    (i32x4.load16x4_u (local.get $0))
  )
  (func (export "i64x2.load32x2_s") (param $0 i32) (result v128)
    (i64x2.load32x2_s (local.get $0))
  )
  (func (export "i64x2.load32x2_u") (param $0 i32) (result v128)
    (i64x2.load32x2_u (local.get $0))
  )

  ;; load by a constant amount
  (func (export "i16x8.load8x8_s_const0") (result v128)
    (i16x8.load8x8_s (i32.const 0))
  )
  (func (export "i16x8.load8x8_u_const8") (result v128)
    (i16x8.load8x8_u (i32.const 8))
  )
  (func (export "i32x4.load16x4_s_const10") (result v128)
    (i32x4.load16x4_s (i32.const 10))
  )
  (func (export "i32x4.load16x4_u_const20") (result v128)
    (i32x4.load16x4_u (i32.const 20))
  )
  (func (export "i64x2.load32x2_s_const65520") (result v128)
    (i64x2.load32x2_s (i32.const 65520))
  )
  (func (export "i64x2.load32x2_u_const65526") (result v128)
    (i64x2.load32x2_u (i32.const 65526))
  )

  ;; load data with different offset/align arguments
  ;; i16x8
  (func (export "i16x8.load8x8_s_offset0") (param $0 i32) (result v128)
    (i16x8.load8x8_s offset=0 (local.get $0))
  )
  (func (export "i16x8.load8x8_s_align1") (param $0 i32) (result v128)
    (i16x8.load8x8_s align=1 (local.get $0))
  )
  (func (export "i16x8.load8x8_s_offset0_align1") (param $0 i32) (result v128)
    (i16x8.load8x8_s offset=0 align=1 (local.get $0))
  )
  (func (export "i16x8.load8x8_s_offset1_align1") (param $0 i32) (result v128)
    (i16x8.load8x8_s offset=1 align=1 (local.get $0))
  )
  (func (export "i16x8.load8x8_s_offset10_align4") (param $0 i32) (result v128)
    (i16x8.load8x8_s offset=10 align=4 (local.get $0))
  )
  (func (export "i16x8.load8x8_s_offset20_align8") (param $0 i32) (result v128)
    (i16x8.load8x8_s offset=20 align=8 (local.get $0))
  )
  (func (export "i16x8.load8x8_u_offset0") (param $0 i32) (result v128)
    (i16x8.load8x8_u offset=0 (local.get $0))
  )
  (func (export "i16x8.load8x8_u_align1") (param $0 i32) (result v128)
    (i16x8.load8x8_u align=1 (local.get $0))
  )
  (func (export "i16x8.load8x8_u_offset0_align1") (param $0 i32) (result v128)
    (i16x8.load8x8_u offset=0 align=1 (local.get $0))
  )
  (func (export "i16x8.load8x8_u_offset1_align1") (param $0 i32) (result v128)
    (i16x8.load8x8_u offset=1 align=1 (local.get $0))
  )
  (func (export "i16x8.load8x8_u_offset10_align4") (param $0 i32) (result v128)
    (i16x8.load8x8_u offset=10 align=4 (local.get $0))
  )
  (func (export "i16x8.load8x8_u_offset20_align8") (param $0 i32) (result v128)
    (i16x8.load8x8_u offset=20 align=8 (local.get $0))
  )
  ;; i32x4
  (func (export "i32x4.load16x4_s_offset0") (param $0 i32) (result v128)
    (i32x4.load16x4_s offset=0 (local.get $0))
  )
  (func (export "i32x4.load16x4_s_align1") (param $0 i32) (result v128)
    (i32x4.load16x4_s align=1 (local.get $0))
  )
  (func (export "i32x4.load16x4_s_offset0_align1") (param $0 i32) (result v128)
    (i32x4.load16x4_s offset=0 align=1 (local.get $0))
  )
  (func (export "i32x4.load16x4_s_offset1_align1") (param $0 i32) (result v128)
    (i32x4.load16x4_s offset=1 align=1 (local.get $0))
  )
  (func (export "i32x4.load16x4_s_offset10_align4") (param $0 i32) (result v128)
    (i32x4.load16x4_s offset=10 align=4 (local.get $0))
  )
  (func (export "i32x4.load16x4_s_offset20_align8") (param $0 i32) (result v128)
    (i32x4.load16x4_s offset=20 align=8 (local.get $0))
  )
  (func (export "i32x4.load16x4_u_offset0") (param $0 i32) (result v128)
    (i32x4.load16x4_u offset=0 (local.get $0))
  )
  (func (export "i32x4.load16x4_u_align1") (param $0 i32) (result v128)
    (i32x4.load16x4_u align=1 (local.get $0))
  )
  (func (export "i32x4.load16x4_u_offset0_align1") (param $0 i32) (result v128)
    (i32x4.load16x4_u offset=0 align=1 (local.get $0))
  )
  (func (export "i32x4.load16x4_u_offset1_align1") (param $0 i32) (result v128)
    (i32x4.load16x4_u offset=1 align=1 (local.get $0))
  )
  (func (export "i32x4.load16x4_u_offset10_align4") (param $0 i32) (result v128)
    (i32x4.load16x4_u offset=10 align=4 (local.get $0))
  )
  (func (export "i32x4.load16x4_u_offset20_align8") (param $0 i32) (result v128)
    (i32x4.load16x4_u offset=20 align=8 (local.get $0))
  )
  ;; i64x2
  (func (export "i64x2.load32x2_s_offset0") (param $0 i32) (result v128)
    (i64x2.load32x2_s offset=0 (local.get $0))
  )
  (func (export "i64x2.load32x2_s_align1") (param $0 i32) (result v128)
    (i64x2.load32x2_s align=1 (local.get $0))
  )
  (func (export "i64x2.load32x2_s_offset0_align1") (param $0 i32) (result v128)
    (i64x2.load32x2_s offset=0 align=1 (local.get $0))
  )
  (func (export "i64x2.load32x2_s_offset1_align1") (param $0 i32) (result v128)
    (i64x2.load32x2_s offset=1 align=1 (local.get $0))
  )
  (func (export "i64x2.load32x2_s_offset10_align4") (param $0 i32) (result v128)
    (i64x2.load32x2_s offset=10 align=4 (local.get $0))
  )
  (func (export "i64x2.load32x2_s_offset20_align8") (param $0 i32) (result v128)
    (i64x2.load32x2_s offset=20 align=8 (local.get $0))
  )
  (func (export "i64x2.load32x2_u_offset0") (param $0 i32) (result v128)
    (i64x2.load32x2_u offset=0 (local.get $0))
  )
  (func (export "i64x2.load32x2_u_align1") (param $0 i32) (result v128)
    (i64x2.load32x2_u align=1 (local.get $0))
  )
  (func (export "i64x2.load32x2_u_offset0_align1") (param $0 i32) (result v128)
    (i64x2.load32x2_u offset=0 align=1 (local.get $0))
  )
  (func (export "i64x2.load32x2_u_offset1_align1") (param $0 i32) (result v128)
    (i64x2.load32x2_u offset=1 align=1 (local.get $0))
  )
  (func (export "i64x2.load32x2_u_offset10_align4") (param $0 i32) (result v128)
    (i64x2.load32x2_u offset=10 align=4 (local.get $0))
  )
  (func (export "i64x2.load32x2_u_offset20_align8") (param $0 i32) (result v128)
    (i64x2.load32x2_u offset=20 align=8 (local.get $0))
  )
)


;; normal
(assert_return (invoke "i16x8.load8x8_s" (i32.const 0)) (v128.const i16x8 0x0000 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007))
(assert_return (invoke "i16x8.load8x8_u" (i32.const 0)) (v128.const i16x8 0x0000 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007))
(assert_return (invoke "i32x4.load16x4_s" (i32.const 0)) (v128.const i32x4 0x00000100 0x00000302 0x00000504 0x00000706))
(assert_return (invoke "i32x4.load16x4_u" (i32.const 0)) (v128.const i32x4 0x00000100 0x00000302 0x00000504 0x00000706))
(assert_return (invoke "i64x2.load32x2_s" (i32.const 0)) (v128.const i64x2 0x0000000003020100 0x0000000007060504))
(assert_return (invoke "i64x2.load32x2_u" (i32.const 0)) (v128.const i64x2 0x0000000003020100 0x0000000007060504))
(assert_return (invoke "i16x8.load8x8_s" (i32.const 10)) (v128.const i16x8 0x000A 0x000B 0x000C 0x000D 0x000E 0x000F 0xFF80 0xFF81))
(assert_return (invoke "i16x8.load8x8_u" (i32.const 10)) (v128.const i16x8 0x000A 0x000B 0x000C 0x000D 0x000E 0x000F 0x0080 0x0081))
(assert_return (invoke "i32x4.load16x4_s" (i32.const 10)) (v128.const i32x4 0x00000B0A 0x00000D0C 0x00000F0E 0xFFFF8180))
(assert_return (invoke "i32x4.load16x4_u" (i32.const 10)) (v128.const i32x4 0x00000B0A 0x00000D0C 0x00000F0E 0x00008180))
(assert_return (invoke "i64x2.load32x2_s" (i32.const 10)) (v128.const i64x2 0x000000000D0C0B0A 0xFFFFFFFF81800F0E))
(assert_return (invoke "i64x2.load32x2_u" (i32.const 10)) (v128.const i64x2 0x000000000D0C0B0A 0x0000000081800F0E))
(assert_return (invoke "i16x8.load8x8_s" (i32.const 20)) (v128.const i16x8 0xff84 0xff85 0xff86 0xff87 0xff88 0xff89 0x0000 0x0000))
(assert_return (invoke "i16x8.load8x8_u" (i32.const 20)) (v128.const i16x8 0x0084 0x0085 0x0086 0x0087 0x0088 0x0089 0x0000 0x0000))
(assert_return (invoke "i32x4.load16x4_s" (i32.const 20)) (v128.const i32x4 0xffff8584 0xffff8786 0xffff8988 0x00000000))
(assert_return (invoke "i32x4.load16x4_u" (i32.const 20)) (v128.const i32x4 0x00008584 0x00008786 0x00008988 0x00000000))
(assert_return (invoke "i64x2.load32x2_s" (i32.const 20)) (v128.const i64x2 0xFFFFFFFF87868584 0x0000000000008988))
(assert_return (invoke "i64x2.load32x2_u" (i32.const 20)) (v128.const i64x2 0x0000000087868584 0x0000000000008988))

;; load by a constant amount
(assert_return (invoke "i16x8.load8x8_s_const0") (v128.const i16x8 0x0000 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007))
(assert_return (invoke "i16x8.load8x8_u_const8") (v128.const i16x8 0x0008 0x0009 0x000A 0x000B 0x000C 0x000D 0x000E 0x000F))
(assert_return (invoke "i32x4.load16x4_s_const10") (v128.const i32x4 0x00000B0A 0x00000D0C 0x00000F0E 0xFFFF8180))
(assert_return (invoke "i32x4.load16x4_u_const20") (v128.const i32x4 0x00008584 0x00008786 0x00008988 0x00000000))
(assert_return (invoke "i64x2.load32x2_s_const65520") (v128.const i64x2 0x000000000D0C0B0A 0xFFFFFFFF81800F0E))
(assert_return (invoke "i64x2.load32x2_u_const65526") (v128.const i64x2 0x0000000083828180 0x0000000087868584))

;; load data with different offset/align arguments
;; i16x8
(assert_return (invoke "i16x8.load8x8_s_offset0" (i32.const 0)) (v128.const i16x8 0x0000 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007))
(assert_return (invoke "i16x8.load8x8_s_align1" (i32.const 1)) (v128.const i16x8 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007 0x0008))
(assert_return (invoke "i16x8.load8x8_s_offset0_align1" (i32.const 2)) (v128.const i16x8 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007 0x0008 0x0009))
(assert_return (invoke "i16x8.load8x8_s_offset10_align4" (i32.const 3)) (v128.const i16x8 0x000D 0x000E 0x000F 0xFF80 0xFF81 0xFF82 0xFF83 0xFF84))
(assert_return (invoke "i16x8.load8x8_s_offset20_align8" (i32.const 4)) (v128.const i16x8 0xFF88 0xFF89 0x0000 0x0000 0x0000 0x0000 0x0000 0x0000))
(assert_return (invoke "i16x8.load8x8_u_offset0" (i32.const 0)) (v128.const i16x8 0x0000 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007))
(assert_return (invoke "i16x8.load8x8_u_align1" (i32.const 1)) (v128.const i16x8 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007 0x0008))
(assert_return (invoke "i16x8.load8x8_u_offset0_align1" (i32.const 2)) (v128.const i16x8 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007 0x0008 0x0009))
(assert_return (invoke "i16x8.load8x8_u_offset10_align4" (i32.const 3)) (v128.const i16x8 0x000D 0x000E 0x000F 0x0080 0x0081 0x0082 0x0083 0x0084))
(assert_return (invoke "i16x8.load8x8_u_offset20_align8" (i32.const 4)) (v128.const i16x8 0x0088 0x0089 0x0000 0x0000 0x0000 0x0000 0x0000 0x0000))
;; i32x4
(assert_return (invoke "i32x4.load16x4_s_offset0" (i32.const 0)) (v128.const i32x4 0x00000100 0x00000302 0x00000504 0x00000706))
(assert_return (invoke "i32x4.load16x4_s_align1" (i32.const 1)) (v128.const i32x4 0x00000201 0x00000403 0x00000605 0x00000807))
(assert_return (invoke "i32x4.load16x4_s_offset0_align1" (i32.const 2)) (v128.const i32x4 0x00000302 0x00000504 0x00000706 0x00000908))
(assert_return (invoke "i32x4.load16x4_s_offset10_align4" (i32.const 3)) (v128.const i32x4 0x00000E0D 0xFFFF800F 0xFFFF8281 0xFFFF8483))
(assert_return (invoke "i32x4.load16x4_s_offset20_align8" (i32.const 4)) (v128.const i32x4 0xFFFF8988 0x00000000 0x00000000 0x00000000))
(assert_return (invoke "i32x4.load16x4_u_offset0" (i32.const 0)) (v128.const i32x4 0x00000100 0x00000302 0x00000504 0x00000706))
(assert_return (invoke "i32x4.load16x4_u_align1" (i32.const 1)) (v128.const i32x4 0x00000201 0x00000403 0x00000605 0x00000807))
(assert_return (invoke "i32x4.load16x4_u_offset0_align1" (i32.const 2)) (v128.const i32x4 0x00000302 0x00000504 0x00000706 0x00000908))
(assert_return (invoke "i32x4.load16x4_u_offset10_align4" (i32.const 3)) (v128.const i32x4 0x00000E0D 0x0000800F 0x00008281 0x00008483))
(assert_return (invoke "i32x4.load16x4_u_offset20_align8" (i32.const 4)) (v128.const i32x4 0x00008988 0x00000000 0x00000000 0x00000000))
;; i64x2
(assert_return (invoke "i64x2.load32x2_s_offset0" (i32.const 0)) (v128.const i64x2 0x0000000003020100 0x0000000007060504))
(assert_return (invoke "i64x2.load32x2_s_align1" (i32.const 1)) (v128.const i64x2 0x0000000004030201 0x0000000008070605))
(assert_return (invoke "i64x2.load32x2_s_offset0_align1" (i32.const 2)) (v128.const i64x2 0x0000000005040302 0x0000000009080706))
(assert_return (invoke "i64x2.load32x2_s_offset10_align4" (i32.const 3)) (v128.const i64x2 0xFFFFFFFF800F0E0D 0xFFFFFFFF84838281))
(assert_return (invoke "i64x2.load32x2_s_offset20_align8" (i32.const 4)) (v128.const i64x2 0x0000000000008988 0x0000000000000000))
(assert_return (invoke "i64x2.load32x2_u_offset0" (i32.const 0)) (v128.const i64x2 0x0000000003020100 0x0000000007060504))
(assert_return (invoke "i64x2.load32x2_u_align1" (i32.const 1)) (v128.const i64x2 0x0000000004030201 0x0000000008070605))
(assert_return (invoke "i64x2.load32x2_u_offset0_align1" (i32.const 2)) (v128.const i64x2 0x0000000005040302 0x0000000009080706))
(assert_return (invoke "i64x2.load32x2_u_offset10_align4" (i32.const 3)) (v128.const i64x2 0x00000000800F0E0D 0x0000000084838281))
(assert_return (invoke "i64x2.load32x2_u_offset20_align8" (i32.const 4)) (v128.const i64x2 0x0000000000008988 0x0000000000000000))

;; out of bounds memory access
(assert_trap (invoke "i16x8.load8x8_s" (i32.const -1))  "out of bounds memory access")
(assert_trap (invoke "i16x8.load8x8_u" (i32.const -1))  "out of bounds memory access")
(assert_trap (invoke "i32x4.load16x4_s" (i32.const 65536))  "out of bounds memory access")
(assert_trap (invoke "i32x4.load16x4_u" (i32.const 65536))  "out of bounds memory access")
(assert_trap (invoke "i64x2.load32x2_s" (i32.const 65529))  "out of bounds memory access")
(assert_trap (invoke "i64x2.load32x2_u" (i32.const 65529))  "out of bounds memory access")

(assert_trap (invoke "i16x8.load8x8_s_offset1_align1" (i32.const -1)) "out of bounds memory access")
(assert_trap (invoke "i16x8.load8x8_u_offset1_align1" (i32.const -1)) "out of bounds memory access")
(assert_trap (invoke "i32x4.load16x4_s_offset1_align1" (i32.const -1)) "out of bounds memory access")
(assert_trap (invoke "i32x4.load16x4_u_offset1_align1" (i32.const -1)) "out of bounds memory access")
(assert_trap (invoke "i64x2.load32x2_s_offset1_align1" (i32.const -1)) "out of bounds memory access")
(assert_trap (invoke "i64x2.load32x2_u_offset1_align1" (i32.const -1)) "out of bounds memory access")

;; type check
(assert_invalid (module (memory 0) (func (result v128) (i16x8.load8x8_s (f32.const 0)))) "type mismatch")
(assert_invalid (module (memory 0) (func (result v128) (i16x8.load8x8_u (f32.const 0)))) "type mismatch")
(assert_invalid (module (memory 0) (func (result v128) (i32x4.load16x4_s (f64.const 0)))) "type mismatch")
(assert_invalid (module (memory 0) (func (result v128) (i32x4.load16x4_u (f64.const 0)))) "type mismatch")
(assert_invalid (module (memory 0) (func (result v128) (i64x2.load32x2_s (v128.const i32x4 0 0 0 0)))) "type mismatch")
(assert_invalid (module (memory 0) (func (result v128) (i64x2.load32x2_u (v128.const i32x4 0 0 0 0)))) "type mismatch")

;; Test operation with empty argument

(assert_invalid
  (module (memory 0)
    (func $i16x8.load8x8_s-arg-empty (result v128)
      (i16x8.load8x8_s)
    )
  )
  "type mismatch"
)
(assert_invalid
  (module (memory 0)
    (func $i16x8.load8x8_u-arg-empty (result v128)
      (i16x8.load8x8_u)
    )
  )
  "type mismatch"
)
(assert_invalid
  (module (memory 0)
    (func $i32x4.load16x4_s-arg-empty (result v128)
      (i32x4.load16x4_s)
    )
  )
  "type mismatch"
)
(assert_invalid
  (module (memory 0)
    (func $i32x4.load16x4_u-arg-empty (result v128)
      (i32x4.load16x4_u)
    )
  )
  "type mismatch"
)
(assert_invalid
  (module (memory 0)
    (func $i64x2.load32x2_s-arg-empty (result v128)
      (i64x2.load32x2_s)
    )
  )
  "type mismatch"
)
(assert_invalid
  (module (memory 0)
    (func $i64x2.load32x2_u-arg-empty (result v128)
      (i64x2.load32x2_u)
    )
  )
  "type mismatch"
)

;; Unknown operator

(assert_malformed (module quote "(memory 1) (func (drop (i16x8.load16x4_s (i32.const 0))))") "unknown operator")
(assert_malformed (module quote "(memory 1) (func (drop (i16x8.load16x4_u (i32.const 0))))") "unknown operator")
(assert_malformed (module quote "(memory 1) (func (drop (i32x4.load32x2_s (i32.const 0))))") "unknown operator")
(assert_malformed (module quote "(memory 1) (func (drop (i32x4.load32x2_u (i32.const 0))))") "unknown operator")
(assert_malformed (module quote "(memory 1) (func (drop (i64x2.load64x1_s (i32.const 0))))") "unknown operator")
(assert_malformed (module quote "(memory 1) (func (drop (i64x2.load64x1_u (i32.const 0))))") "unknown operator")

;; combination
(module
  (memory 1)
  (data (i32.const 0) "\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\80\81\82\83\84\85\86\87\88\89")
  (func (export "i16x8.load8x8_s-in-block") (result v128)
    (block (result v128) (block (result v128) (i16x8.load8x8_s (i32.const 0))))
  )
  (func (export "i16x8.load8x8_u-in-block") (result v128)
    (block (result v128) (block (result v128) (i16x8.load8x8_u (i32.const 1))))
  )
  (func (export "i32x4.load16x4_s-in-block") (result v128)
    (block (result v128) (block (result v128) (i32x4.load16x4_s (i32.const 2))))
  )
  (func (export "i32x4.load16x4_u-in-block") (result v128)
    (block (result v128) (block (result v128) (i32x4.load16x4_u (i32.const 3))))
  )
  (func (export "i64x2.load32x2_s-in-block") (result v128)
    (block (result v128) (block (result v128) (i64x2.load32x2_s (i32.const 4))))
  )
  (func (export "i64x2.load32x2_u-in-block") (result v128)
    (block (result v128) (block (result v128) (i64x2.load32x2_u (i32.const 5))))
  )
  (func (export "i16x8.load8x8_s-as-br-value") (result v128)
    (block (result v128) (br 0 (i16x8.load8x8_s (i32.const 6))))
  )
  (func (export "i16x8.load8x8_u-as-br-value") (result v128)
    (block (result v128) (br 0 (i16x8.load8x8_u (i32.const 7))))
  )
  (func (export "i32x4.load16x4_s-as-br-value") (result v128)
    (block (result v128) (br 0 (i32x4.load16x4_s (i32.const 8))))
  )
  (func (export "i32x4.load16x4_u-as-br-value") (result v128)
    (block (result v128) (br 0 (i32x4.load16x4_u (i32.const 9))))
  )
  (func (export "i64x2.load32x2_s-as-br-value") (result v128)
    (block (result v128) (br 0 (i64x2.load32x2_s (i32.const 10))))
  )
  (func (export "i64x2.load32x2_u-as-br-value") (result v128)
    (block (result v128) (br 0 (i64x2.load32x2_u (i32.const 11))))
  )
  (func (export "i16x8.load8x8_s-extract_lane_s-operand") (result i32)
    (i8x16.extract_lane_s 0 (i16x8.load8x8_s (i32.const 12)))
  )
  (func (export "i16x8.load8x8_u-extract_lane_s-operand") (result i32)
    (i8x16.extract_lane_s 0 (i16x8.load8x8_u (i32.const 13)))
  )
  (func (export "i32x4.load16x4_s-extract_lane_s-operand") (result i32)
    (i8x16.extract_lane_s 0 (i32x4.load16x4_s (i32.const 14)))
  )
  (func (export "i32x4.load16x4_u-extract_lane_s-operand") (result i32)
    (i8x16.extract_lane_s 0 (i32x4.load16x4_u (i32.const 15)))
  )
  (func (export "i64x2.load32x2_s-extract_lane_s-operand") (result i32)
    (i8x16.extract_lane_s 0 (i64x2.load32x2_s (i32.const 16)))
  )
  (func (export "i64x2.load32x2_u-extract_lane_s-operand") (result i32)
    (i8x16.extract_lane_s 0 (i64x2.load32x2_u (i32.const 17)))
  )
)
(assert_return (invoke "i16x8.load8x8_s-in-block") (v128.const i16x8 0x0000 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007))
(assert_return (invoke "i16x8.load8x8_u-in-block") (v128.const i16x8 0x0001 0x0002 0x0003 0x0004 0x0005 0x0006 0x0007 0x0008))
(assert_return (invoke "i32x4.load16x4_s-in-block") (v128.const i32x4 0x00000302 0x00000504 0x00000706 0x00000908))
(assert_return (invoke "i32x4.load16x4_u-in-block") (v128.const i32x4 0x00000403 0x00000605 0x00000807 0x00000A09))
(assert_return (invoke "i64x2.load32x2_s-in-block") (v128.const i64x2 0x0000000007060504 0x000000000B0A0908))
(assert_return (invoke "i64x2.load32x2_u-in-block") (v128.const i64x2 0x0000000008070605 0x000000000C0B0A09))
(assert_return (invoke "i16x8.load8x8_s-as-br-value") (v128.const i16x8 0x0006 0x0007 0x0008 0x0009 0x000A 0x000B 0x000C 0x000D))
(assert_return (invoke "i16x8.load8x8_u-as-br-value") (v128.const i16x8 0x0007 0x0008 0x0009 0x000A 0x000B 0x000C 0x000D 0x000E))
(assert_return (invoke "i32x4.load16x4_s-as-br-value") (v128.const i32x4 0x00000908 0x00000B0A 0x00000D0C 0x00000F0E))
(assert_return (invoke "i32x4.load16x4_u-as-br-value") (v128.const i32x4 0x00000A09 0x00000C0B 0x00000E0D 0x0000800F))
(assert_return (invoke "i64x2.load32x2_s-as-br-value") (v128.const i64x2 0x000000000D0C0B0A 0xFFFFFFFF81800F0E))
(assert_return (invoke "i64x2.load32x2_u-as-br-value") (v128.const i64x2 0x000000000E0D0C0B 0x000000008281800F))
(assert_return (invoke "i16x8.load8x8_s-extract_lane_s-operand") (i32.const 12))
(assert_return (invoke "i16x8.load8x8_u-extract_lane_s-operand") (i32.const 13))
(assert_return (invoke "i32x4.load16x4_s-extract_lane_s-operand") (i32.const 14))
(assert_return (invoke "i32x4.load16x4_u-extract_lane_s-operand") (i32.const 15))
(assert_return (invoke "i64x2.load32x2_s-extract_lane_s-operand") (i32.const -128))
(assert_return (invoke "i64x2.load32x2_u-extract_lane_s-operand") (i32.const -127))
