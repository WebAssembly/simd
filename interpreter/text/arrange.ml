open Source
open Ast
open Script
open Values
open Types
open Sexpr


(* Generic formatting *)

let nat n = I32.to_string_u (I32.of_int_u n)
let nat32 = I32.to_string_u

let add_hex_char buf c = Printf.bprintf buf "\\%02x" (Char.code c)
let add_char buf = function
  | '\n' -> Buffer.add_string buf "\\n"
  | '\t' -> Buffer.add_string buf "\\t"
  | '\"' -> Buffer.add_string buf "\\\""
  | '\\' -> Buffer.add_string buf "\\\\"
  | c when '\x20' <= c && c < '\x7f' -> Buffer.add_char buf c
  | c -> add_hex_char buf c
let add_unicode_char buf = function
  | (0x09 | 0x0a) as uc -> add_char buf (Char.chr uc)
  | uc when 0x20 <= uc && uc < 0x7f -> add_char buf (Char.chr uc)
  | uc -> Printf.bprintf buf "\\u{%02x}" uc

let string_with iter add_char s =
  let buf = Buffer.create 256 in
  Buffer.add_char buf '\"';
  iter (add_char buf) s;
  Buffer.add_char buf '\"';
  Buffer.contents buf

let bytes = string_with String.iter add_hex_char
let string = string_with String.iter add_char
let name = string_with List.iter add_unicode_char

let list_of_opt = function None -> [] | Some x -> [x]

let list f xs = List.map f xs
let listi f xs = List.mapi f xs
let opt f xo = list f (list_of_opt xo)

let tab head f xs = if xs = [] then [] else [Node (head, list f xs)]
let atom f x = Atom (f x)

let break_bytes s =
  let ss = Lib.String.breakup s 16 in
  list (atom bytes) ss

let break_string s =
  let ss, s' = Lib.List.split_last (Lib.String.split s '\n') in
  list (atom string) (List.map (fun s -> s ^ "\n") ss @ [s'])


(* Types *)

let value_type t = string_of_value_type t

let elem_type t = string_of_elem_type t

let decls kind ts = tab kind (atom value_type) ts

let func_type (FuncType (ins, out)) =
  Node ("func", decls "param" ins @ decls "result" out)

let struct_type = func_type

let limits nat {min; max} =
  String.concat " " (nat min :: opt nat max)

let global_type = function
  | GlobalType (t, Immutable) -> atom string_of_value_type t
  | GlobalType (t, Mutable) -> Node ("mut", [atom string_of_value_type t])

let pack_size = function
  | Pack8 -> "8"
  | Pack16 -> "16"
  | Pack32 -> "32"

let extension = function
  | SX -> "_s"
  | ZX -> "_u"


(* Operators *)

module IntOp =
struct
  open Ast.IntOp

  let testop xx = function
    | Eqz -> "eqz"

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | LtS -> "lt_s"
    | LtU -> "lt_u"
    | GtS -> "gt_s"
    | GtU -> "gt_u"
    | LeS -> "le_s"
    | LeU -> "le_u"
    | GeS -> "ge_s"
    | GeU -> "ge_u"

  let unop xx = function
    | Clz -> "clz"
    | Ctz -> "ctz"
    | Popcnt -> "popcnt"
    | ExtendS sz -> "extend" ^ pack_size sz ^ "_s"

  let binop xx = function
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | DivS -> "div_s"
    | DivU -> "div_u"
    | RemS -> "rem_s"
    | RemU -> "rem_u"
    | And -> "and"
    | Or -> "or"
    | Xor -> "xor"
    | Shl -> "shl"
    | ShrS -> "shr_s"
    | ShrU -> "shr_u"
    | Rotl -> "rotl"
    | Rotr -> "rotr"

  let cvtop xx = function
    | ExtendSI32 -> "extend_i32_s"
    | ExtendUI32 -> "extend_i32_u"
    | WrapI64 -> "wrap_i64"
    | TruncSF32 -> "trunc_f32_s"
    | TruncUF32 -> "trunc_f32_u"
    | TruncSF64 -> "trunc_f64_s"
    | TruncUF64 -> "trunc_f64_u"
    | TruncSatSF32 -> "trunc_sat_f32_s"
    | TruncSatUF32 -> "trunc_sat_f32_u"
    | TruncSatSF64 -> "trunc_sat_f64_s"
    | TruncSatUF64 -> "trunc_sat_f64_u"
    | ReinterpretFloat -> "reinterpret_f" ^ xx
end

module FloatOp =
struct
  open Ast.FloatOp

  let testop xx = fun _ -> assert false

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | Lt -> "lt"
    | Gt -> "gt"
    | Le -> "le"
    | Ge -> "ge"

  let unop xx = function
    | Neg -> "neg"
    | Abs -> "abs"
    | Ceil -> "ceil"
    | Floor -> "floor"
    | Trunc -> "trunc"
    | Nearest -> "nearest"
    | Sqrt -> "sqrt"

  let binop xx = function
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | Div -> "div"
    | Min -> "min"
    | Max -> "max"
    | CopySign -> "copysign"

  let cvtop xx = function
    | ConvertSI32 -> "convert_i32_s"
    | ConvertUI32 -> "convert_i32_u"
    | ConvertSI64 -> "convert_i64_s"
    | ConvertUI64 -> "convert_i64_u"
    | PromoteF32 -> "promote_f32"
    | DemoteF64 -> "demote_f64"
    | ReinterpretInt -> "reinterpret_i" ^ xx
end

(* FIXME *)
module SimdOp =
struct
  open Ast.SimdOp

  let testop xx = fun _ -> failwith "TODO v128"

  let relop xx = fun _ -> failwith "TODO v128"

  let unop xx (op : unop) = match op with
    | I8x16 Neg -> "i8x16.neg"
    | I8x16 Abs -> "i8x16.abs"
    | I16x8 Abs -> "i16x8.abs"
    | I16x8 Neg -> "i16x8.neg"
    | I32x4 Abs -> "i32x4.abs"
    | I32x4 Neg -> "i32x4.neg"
    | I64x2 Neg -> "i64x2.neg"
    | F32x4 Abs -> "f32x4.abs"
    | F32x4 Neg -> "f32x4.neg"
    | F32x4 Sqrt -> "f32x4.sqrt"
    | F64x2 Abs -> "f64x2.abs"
    | F64x2 Neg -> "f64x2.neg"
    | F64x2 Sqrt -> "f64x2.sqrt"
    | V128 Not -> "v128.not"
    | _ -> failwith "Unimplemented v128 unop"

  let binop xx (op : binop) = match op with
    | I8x16 Eq -> "i8x16.eq"
    | I8x16 Ne -> "i8x16.ne"
    | I8x16 LtS -> "i8x16.lt_s"
    | I8x16 LtU -> "i8x16.lt_u"
    | I8x16 GtS -> "i8x16.gt_s"
    | I8x16 GtU -> "i8x16.gt_u"
    | I8x16 LeS -> "i8x16.le_s"
    | I8x16 LeU -> "i8x16.le_u"
    | I8x16 GeS -> "i8x16.ge_s"
    | I8x16 GeU -> "i8x16.ge_u"
    | I16x8 Eq -> "i16x8.eq"
    | I16x8 Ne -> "i16x8.ne"
    | I16x8 LtS -> "i16x8.lt_s"
    | I16x8 LtU -> "i16x8.lt_u"
    | I16x8 GtS -> "i16x8.gt_s"
    | I16x8 GtU -> "i16x8.gt_u"
    | I16x8 LeS -> "i16x8.le_s"
    | I16x8 LeU -> "i16x8.le_u"
    | I16x8 GeS -> "i16x8.ge_s"
    | I16x8 GeU -> "i16x8.ge_u"
    | I32x4 Eq -> "i32x4.eq"
    | I32x4 Ne -> "i32x4.ne"
    | I32x4 LtS -> "i32x4.lt_s"
    | I32x4 LtU -> "i32x4.lt_u"
    | I32x4 GtS -> "i32x4.gt_s"
    | I32x4 GtU -> "i32x4.gt_u"
    | I32x4 LeS -> "i32x4.le_s"
    | I32x4 LeU -> "i32x4.le_u"
    | I32x4 GeS -> "i32x4.ge_s"
    | I32x4 GeU -> "i32x4.ge_u"
    | I8x16 Add -> "i8x16.add"
    | I8x16 Sub -> "i8x16.sub"
    | I8x16 MinS -> "i8x16.min_s"
    | I8x16 MinU -> "i8x16.min_u"
    | I8x16 MaxS -> "i8x16.max_s"
    | I8x16 MaxU -> "i8x16.max_u"
    | I8x16 AvgrU -> "i8x16.avgr_u"
    | I16x8 Add -> "i16x8.add"
    | I16x8 Sub -> "i16x8.sub"
    | I16x8 Mul -> "i16x8.mul"
    | I16x8 MinS -> "i16x8.min_s"
    | I16x8 MinU -> "i16x8.min_u"
    | I16x8 MaxS -> "i16x8.max_s"
    | I16x8 MaxU -> "i16x8.max_u"
    | I16x8 AvgrU -> "i16x8.avgr_u"
    | I32x4 Add -> "i32x4.add"
    | I32x4 Sub -> "i32x4.sub"
    | I32x4 Mul -> "i32x4.mul"
    | I32x4 MinS -> "i32x4.min_s"
    | I32x4 MinU -> "i32x4.min_u"
    | I32x4 MaxS -> "i32x4.max_s"
    | I32x4 MaxU -> "i32x4.max_u"
    | I64x2 Add -> "i64x2.add"
    | I64x2 Sub -> "i64x2.sub"
    | I64x2 Mul -> "i64x2.mul"
    | F32x4 Eq -> "f32x4.eq"
    | F32x4 Ne -> "f32x4.ne"
    | F32x4 Lt -> "f32x4.lt"
    | F32x4 Le -> "f32x4.le"
    | F32x4 Gt -> "f32x4.gt"
    | F32x4 Ge -> "f32x4.ge"
    | F32x4 Add -> "f32x4.add"
    | F32x4 Sub -> "f32x4.sub"
    | F32x4 Mul -> "f32x4.mul"
    | F32x4 Div -> "f32x4.div"
    | F32x4 Min -> "f32x4.min"
    | F32x4 Max -> "f32x4.max"
    | F64x2 Eq -> "f64x2.eq"
    | F64x2 Ne -> "f64x2.ne"
    | F64x2 Lt -> "f64x2.lt"
    | F64x2 Gt -> "f64x2.gt"
    | F64x2 Le -> "f64x2.le"
    | F64x2 Ge -> "f64x2.ge"
    | F64x2 Add -> "f64x2.add"
    | F64x2 Sub -> "f64x2.sub"
    | F64x2 Mul -> "f64x2.mul"
    | F64x2 Div -> "f64x2.div"
    | F64x2 Min -> "f64x2.min"
    | F64x2 Max -> "f64x2.max"
    | V128 And -> "v128.and"
    | V128 AndNot -> "v128.andnot"
    | V128 Or -> "v128.or"
    | V128 Xor -> "v128.xor"
    | _ -> failwith "Unimplemented v128 binop"

  let ternop (op : ternop) = match op with
    | Bitselect -> "v128.bitselect"

  let cvtop xx = fun _ -> failwith "TODO v128"
end

let oper (intop, floatop, simdop) op =
  (* v128 operations don't need to be prefixed by the type,
   * each instruction will specify their prefix (shape).
   *)
  let prefix = match op with
    | V128 o -> ""
    | _ -> value_type (type_of op) ^ "."
  in
  let ops = match op with
    | I32 o -> intop "32" o
    | I64 o -> intop "64" o
    | F32 o -> floatop "32" o
    | F64 o -> floatop "64" o
    | V128 o -> simdop "128" o
  in prefix ^ ops

let unop = oper (IntOp.unop, FloatOp.unop, SimdOp.unop)
let binop = oper (IntOp.binop, FloatOp.binop, SimdOp.binop)
let testop = oper (IntOp.testop, FloatOp.testop, SimdOp.testop)
let relop = oper (IntOp.relop, FloatOp.relop, SimdOp.relop)
let cvtop = oper (IntOp.cvtop, FloatOp.cvtop, SimdOp.cvtop)
let ternop = SimdOp.ternop

let memop name {ty; align; offset; _} sz =
  value_type ty ^ "." ^ name ^
  (if offset = 0l then "" else " offset=" ^ nat32 offset) ^
  (if 1 lsl align = sz then "" else " align=" ^ nat (1 lsl align))

let loadop op =
  match op.sz with
  | None -> memop "load" op (size op.ty)
  | Some (sz, ext) ->
    memop ("load" ^ pack_size sz ^ extension ext) op (packed_size sz)

let storeop op =
  match op.sz with
  | None -> memop "store" op (size op.ty)
  | Some sz -> memop ("store" ^ pack_size sz) op (packed_size sz)


(* Expressions *)

let var x = nat32 x.it
let value v = string_of_value v.it
let constop v =
  let shape = match v.it with
    | V128 _ -> "i32x4 "
    | _ -> ""
  in value_type (type_of v.it) ^ ".const " ^ shape

let block_type = function
  | VarBlockType x -> [Node ("type " ^ var x, [])]
  | ValBlockType ts -> decls "result" (list_of_opt ts)

let rec instr e =
  let head, inner =
    match e.it with
    | Unreachable -> "unreachable", []
    | Nop -> "nop", []
    | Drop -> "drop", []
    | Select -> "select", []
    | Block (bt, es) -> "block", block_type bt @ list instr es
    | Loop (bt, es) -> "loop", block_type bt @ list instr es
    | If (bt, es1, es2) ->
      "if", block_type bt @
        [Node ("then", list instr es1); Node ("else", list instr es2)]
    | Br x -> "br " ^ var x, []
    | BrIf x -> "br_if " ^ var x, []
    | BrTable (xs, x) ->
      "br_table " ^ String.concat " " (list var (xs @ [x])), []
    | Return -> "return", []
    | Call x -> "call " ^ var x, []
    | CallIndirect x -> "call_indirect", [Node ("type " ^ var x, [])]
    | LocalGet x -> "local.get " ^ var x, []
    | LocalSet x -> "local.set " ^ var x, []
    | LocalTee x -> "local.tee " ^ var x, []
    | GlobalGet x -> "global.get " ^ var x, []
    | GlobalSet x -> "global.set " ^ var x, []
    | Load op -> loadop op, []
    | Store op -> storeop op, []
    | MemorySize -> "memory.size", []
    | MemoryGrow -> "memory.grow", []
    | Const lit -> constop lit ^ value lit, []
    | Test op -> testop op, []
    | Compare op -> relop op, []
    | Unary op -> unop op, []
    | Binary op -> binop op, []
    | Ternary op -> ternop op, []
    | Convert op -> cvtop op, []
    | SimdExtract op -> failwith "TODO v128"
    | SimdReplace op -> failwith "TODO v128"
    | SimdShift op -> failwith "TODO v128"
  in Node (head, inner)

let const c =
  list instr c.it


(* Functions *)

let func_with_name name f =
  let {ftype; locals; body} = f.it in
  Node ("func" ^ name,
    [Node ("type " ^ var ftype, [])] @
    decls "local" locals @
    list instr body
  )

let func_with_index off i f =
  func_with_name (" $" ^ nat (off + i)) f

let func f =
  func_with_name "" f

let start x = Node ("start " ^ var x, [])


(* Tables & memories *)

let table off i tab =
  let {ttype = TableType (lim, t)} = tab.it in
  Node ("table $" ^ nat (off + i) ^ " " ^ limits nat32 lim,
    [atom elem_type t]
  )

let memory off i mem =
  let {mtype = MemoryType lim} = mem.it in
  Node ("memory $" ^ nat (off + i) ^ " " ^ limits nat32 lim, [])

let segment head dat seg =
  let {index; offset; init} = seg.it in
  Node (head, atom var index :: Node ("offset", const offset) :: dat init)

let elems seg =
  segment "elem" (list (atom var)) seg

let data seg =
  segment "data" break_bytes seg


(* Modules *)

let typedef i ty =
  Node ("type $" ^ nat i, [struct_type ty.it])

let import_desc fx tx mx gx d =
  match d.it with
  | FuncImport x ->
    incr fx; Node ("func $" ^ nat (!fx - 1), [Node ("type", [atom var x])])
  | TableImport t ->
    incr tx; table 0 (!tx - 1) ({ttype = t} @@ d.at)
  | MemoryImport t ->
    incr mx; memory 0 (!mx - 1) ({mtype = t} @@ d.at)
  | GlobalImport t ->
    incr gx; Node ("global $" ^ nat (!gx - 1), [global_type t])

let import fx tx mx gx im =
  let {module_name; item_name; idesc} = im.it in
  Node ("import",
    [atom name module_name; atom name item_name; import_desc fx tx mx gx idesc]
  )

let export_desc d =
  match d.it with
  | FuncExport x -> Node ("func", [atom var x])
  | TableExport x -> Node ("table", [atom var x])
  | MemoryExport x -> Node ("memory", [atom var x])
  | GlobalExport x -> Node ("global", [atom var x])

let export ex =
  let {name = n; edesc} = ex.it in
  Node ("export", [atom name n; export_desc edesc])

let global off i g =
  let {gtype; value} = g.it in
  Node ("global $" ^ nat (off + i), global_type gtype :: const value)


(* Modules *)

let var_opt = function
  | None -> ""
  | Some x -> " " ^ x.it

let module_with_var_opt x_opt m =
  let fx = ref 0 in
  let tx = ref 0 in
  let mx = ref 0 in
  let gx = ref 0 in
  let imports = list (import fx tx mx gx) m.it.imports in
  Node ("module" ^ var_opt x_opt,
    listi typedef m.it.types @
    imports @
    listi (table !tx) m.it.tables @
    listi (memory !mx) m.it.memories @
    listi (global !gx) m.it.globals @
    listi (func_with_index !fx) m.it.funcs @
    list export m.it.exports @
    opt start m.it.start @
    list elems m.it.elems @
    list data m.it.data
  )

let binary_module_with_var_opt x_opt bs =
  Node ("module" ^ var_opt x_opt ^ " binary", break_bytes bs)

let quoted_module_with_var_opt x_opt s =
  Node ("module" ^ var_opt x_opt ^ " quote", break_string s)

let module_ = module_with_var_opt None


(* Scripts *)

(* Converts a value to string depending on mode. *)
let literal mode lit =
  let choose_mode bin not_bin = if mode = `Binary then bin else not_bin in
  match lit.it with
  | Values.I32 i -> choose_mode I32.to_hex_string I32.to_string_s i
  | Values.I64 i -> choose_mode I64.to_hex_string I64.to_string_s i
  | Values.F32 z -> choose_mode F32.to_hex_string F32.to_string z
  | Values.F64 z -> choose_mode F64.to_hex_string F64.to_string z
  | Values.V128 v -> choose_mode V128.to_hex_string V128.to_string v

(* Converts a literal into a constant instruction. *)
let constant mode lit =
  let lit_string = literal mode lit in
  Node (constop lit ^ lit_string, [])

let definition mode x_opt def =
  try
    match mode with
    | `Textual ->
      let rec unquote def =
        match def.it with
        | Textual m -> m
        | Encoded (_, bs) -> Decode.decode "" bs
        | Quoted (_, s) -> unquote (Parse.string_to_module s)
      in module_with_var_opt x_opt (unquote def)
    | `Binary ->
      let rec unquote def =
        match def.it with
        | Textual m -> Encode.encode m
        | Encoded (_, bs) -> Encode.encode (Decode.decode "" bs)
        | Quoted (_, s) -> unquote (Parse.string_to_module s)
      in binary_module_with_var_opt x_opt (unquote def)
    | `Original ->
      match def.it with
      | Textual m -> module_with_var_opt x_opt m
      | Encoded (_, bs) -> binary_module_with_var_opt x_opt bs
      | Quoted (_, s) -> quoted_module_with_var_opt x_opt s
  with Parse.Syntax _ ->
    quoted_module_with_var_opt x_opt "<invalid module>"

let access x_opt n =
  String.concat " " [var_opt x_opt; name n]

let action mode act =
  match act.it with
  | Invoke (x_opt, name, lits) ->
    Node ("invoke" ^ access x_opt name, List.map (constant mode) lits)
  | Get (x_opt, name) ->
    Node ("get" ^ access x_opt name, [])

let nan = function
  | CanonicalNan -> "nan:canonical"
  | ArithmeticNan -> "nan:arithmetic"

let result_numpat mode res =
    match res with
    | LitPat lit -> constant mode lit
    | NanPat nanop ->
      match nanop.it with
      | Values.I32 _ | Values.I64 _ | Values.V128 _ -> assert false
      | Values.F32 n -> Node ("f32.const " ^ nan n, [])
      | Values.F64 n -> Node ("f64.const " ^ nan n, [])

let result_simd mode res shape pats =
  (* A different text generation for SIMD, since the literals within
   * a SimdResult do not need the i32.const instruction *)
  let num_pat mode res =
    match res.it with
    | LitPat lit -> literal mode lit
    | NanPat {it = Values.F32 n; _}
    | NanPat {it = Values.F64 n; _} -> nan n
    | _ -> assert false
  in
  let lits = (List.map (num_pat mode) pats) in
  let tokens = ["v128.const"; Simd.string_of_shape shape;] @ lits in
  Node (String.concat " " tokens, [])

let result mode res =
  match res.it with
  | SimdResult (shape, pats) -> result_simd mode res shape pats
  | NumResult n -> result_numpat mode n.it

let assertion mode ass =
  match ass.it with
  | AssertMalformed (def, re) ->
    (match mode, def.it with
    | `Binary, Quoted _ -> []
    | _ ->
      [Node ("assert_malformed", [definition `Original None def; Atom (string re)])]
    )
  | AssertInvalid (def, re) ->
    [Node ("assert_invalid", [definition mode None def; Atom (string re)])]
  | AssertUnlinkable (def, re) ->
    [Node ("assert_unlinkable", [definition mode None def; Atom (string re)])]
  | AssertUninstantiable (def, re) ->
    [Node ("assert_trap", [definition mode None def; Atom (string re)])]
  | AssertReturn (act, results) ->
    [Node ("assert_return", action mode act :: List.map (result mode) results)]
  | AssertTrap (act, re) ->
    [Node ("assert_trap", [action mode act; Atom (string re)])]
  | AssertExhaustion (act, re) ->
    [Node ("assert_exhaustion", [action mode act; Atom (string re)])]

let command mode cmd =
  match cmd.it with
  | Module (x_opt, def) -> [definition mode x_opt def]
  | Register (n, x_opt) -> [Node ("register " ^ name n ^ var_opt x_opt, [])]
  | Action act -> [action mode act]
  | Assertion ass -> assertion mode ass
  | Meta _ -> assert false

let script mode scr = Lib.List.concat_map (command mode) scr
