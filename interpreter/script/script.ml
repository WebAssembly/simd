type var = string Source.phrase

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Encoded of string * string
  | Quoted of string * string

type action = action' Source.phrase
and action' =
  | Invoke of var option * Ast.name * Ast.literal list
  | Get of var option * Ast.name

type assert_return_comparison = comparison' Source.phrase
and comparison' =
  | AssertReturnConstant of Ast.literal list
  | AssertReturnArithmeticNan (* TODO f32x4 | f64x2 *)
  | AssertReturnCanonicalNan (* TODO f32x4 | f64x2 *)
  (* TODO (ref.any) | (ref.func) *)

type assertion = assertion' Source.phrase
and assertion' =
  | AssertMalformed of definition * string
  | AssertInvalid of definition * string
  | AssertUnlinkable of definition * string
  | AssertUninstantiable of definition * string
  | AssertReturn of action * assert_return_comparison
  | AssertTrap of action * string
  | AssertExhaustion of action * string

type command = command' Source.phrase
and command' =
  | Module of var option * definition
  | Register of Ast.name * var option
  | Action of action
  | Assertion of assertion
  | Meta of meta

and meta = meta' Source.phrase
and meta' =
  | Input of var option * string
  | Output of var option * string option
  | Script of var option * script

and script = command list

exception Syntax of Source.region * string
