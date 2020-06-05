open Types
open Values

exception TypeError of int * value * value_type

let of_arg f n v = try f v with Value t -> raise (TypeError (n, v, t))

module SimdOp (SXX : Simd.S) (Value : ValueType with type t = SXX.t) = struct
  open Ast.SimdOp

  let to_value = Value.to_value

  let of_value = of_arg Value.of_value

  let unop (op : unop) v =
    match op with
    | I32x4 Abs -> to_value (SXX.I32x4.abs (of_value 1 v))
    | I32x4 Neg -> to_value (SXX.I32x4.neg (of_value 1 v))
    | F32x4 Abs -> to_value (SXX.F32x4.abs (of_value 1 v))
    | F32x4 Neg -> to_value (SXX.F32x4.neg (of_value 1 v))
    | F32x4 Sqrt -> to_value (SXX.F32x4.sqrt (of_value 1 v))
    | F64x2 Abs -> to_value (SXX.F64x2.abs (of_value 1 v))
    | F64x2 Neg -> to_value (SXX.F64x2.neg (of_value 1 v))
    | F64x2 Sqrt -> to_value (SXX.F64x2.sqrt (of_value 1 v))
    | _ -> failwith "TODO v128 unimplemented unop"

  let binop (op : binop) =
    let f =
      match op with
      | I32x4 Add -> SXX.I32x4.add
      | I32x4 Sub -> SXX.I32x4.sub
      | I32x4 MinS -> SXX.I32x4.min_s
      | I32x4 MinU -> SXX.I32x4.min_u
      | I32x4 MaxS -> SXX.I32x4.max_s
      | I32x4 MaxU -> SXX.I32x4.max_u
      | I32x4 Mul -> SXX.I32x4.mul
      | F32x4 Add -> SXX.F32x4.add
      | F32x4 Sub -> SXX.F32x4.sub
      | F32x4 Mul -> SXX.F32x4.mul
      | F32x4 Div -> SXX.F32x4.div
      | F32x4 Min -> SXX.F32x4.min
      | F32x4 Max -> SXX.F32x4.max
      | F64x2 Add -> SXX.F64x2.add
      | F64x2 Sub -> SXX.F64x2.sub
      | F64x2 Mul -> SXX.F64x2.mul
      | F64x2 Div -> SXX.F64x2.div
      | F64x2 Min -> SXX.F64x2.min
      | F64x2 Max -> SXX.F64x2.max
      | _ -> failwith "TODO v128 unimplemented binop"
    in
    fun v1 v2 -> to_value (f (of_value 1 v1) (of_value 2 v2))

  (* FIXME *)
  let testop op = failwith "TODO v128 unimplemented testop"

  (* FIXME *)
  let relop op = failwith "TODO v128 unimplemented relop"

  let extractop op v =
    match op with
    | F32x4ExtractLane imm -> F32 (SXX.F32x4.extract_lane imm (of_value 1 v))
    | I32x4ExtractLane imm -> I32 (SXX.I32x4.extract_lane imm (of_value 1 v))
end

module V128Op = SimdOp (V128) (Values.V128Value)

module V128CvtOp = struct
  (* TODO
     open Ast.SimdOp
  *)

  (* FIXME *)
  let cvtop op v = failwith "TODO v128"
end

let eval_extractop extractop v = V128Op.extractop extractop v

let unop = V128Op.unop

let binop = V128Op.binop

let testop = V128Op.testop

let relop = V128Op.relop

let cvtop = V128CvtOp.cvtop
