(*
 * Throughout the implementation we use consistent naming conventions for
 * syntactic elements, associated with the types defined here and in a few
 * other places:
 *
 *   x : var
 *   v : value
 *   e : instr
 *   f : func
 *   m : module_
 *
 *   t : value_type
 *   s : func_type
 *   c : context / config
 *
 * These conventions mostly follow standard practice in language semantics.
 *)

open Types


(* Operators *)

module IntOp =
struct
  type unop = Clz | Ctz | Popcnt | ExtendS of pack_size
  type binop = Add | Sub | Mul | DivS | DivU | RemS | RemU
             | And | Or | Xor | Shl | ShrS | ShrU | Rotl | Rotr
  type testop = Eqz
  type relop = Eq | Ne | LtS | LtU | GtS | GtU | LeS | LeU | GeS | GeU
  type cvtop = ExtendSI32 | ExtendUI32 | WrapI64
             | TruncSF32 | TruncUF32 | TruncSF64 | TruncUF64
             | TruncSatSF32 | TruncSatUF32 | TruncSatSF64 | TruncSatUF64
             | ReinterpretFloat
end

module FloatOp =
struct
  type unop = Neg | Abs | Ceil | Floor | Trunc | Nearest | Sqrt
  type binop = Add | Sub | Mul | Div | Min | Max | CopySign
  type testop
  type relop = Eq | Ne | Lt | Gt | Le | Ge
  type cvtop = ConvertSI32 | ConvertUI32 | ConvertSI64 | ConvertUI64
             | PromoteF32 | DemoteF64
             | ReinterpretInt
end

(* FIXME *)
module SimdOp =
struct
  type iunop = Abs | Neg | TruncSatF32x4S | TruncSatF32x4U
              | WidenLowS | WidenLowU | WidenHighS | WidenHighU
  type ibinop = Add | Sub | MinS | MinU | MaxS | MaxU | Mul | AvgrU
              | Eq | Ne | LtS | LtU | LeS | LeU | GtS | GtU | GeS | GeU
              | Swizzle | Shuffle of int list | NarrowS | NarrowU
              | AddSatS | AddSatU | SubSatS | SubSatU
  type funop = Abs | Neg | Sqrt
             | Ceil | Floor | Trunc | Nearest
             | ConvertI32x4S | ConvertI32x4U
  type fbinop = Add | Sub | Mul | Div | Min | Max | Pmin | Pmax
              | Eq | Ne | Lt | Le | Gt | Ge
  type vunop = Not
  type vbinop = And | Or | Xor | AndNot
  type vtestop = AnyTrue | AllTrue

  type ('i8x16, 'i16x8, 'i32x4, 'i64x2, 'f32x4, 'f64x2, 'v128) v128op =
    | I8x16 of 'i8x16
    | I16x8 of 'i16x8
    | I32x4 of 'i32x4
    | I64x2 of 'i64x2
    | F32x4 of 'f32x4
    | F64x2 of 'f64x2
    | V128 of 'v128

  type unop = (iunop, iunop, iunop, iunop, funop, funop, vunop) v128op
  type binop = (ibinop, ibinop, ibinop, ibinop, fbinop, fbinop, vbinop) v128op
  type testop = (vtestop, vtestop, vtestop, vtestop, vtestop, vtestop, vtestop) v128op
  type ternop = Bitselect
  type relop = TodoRelOp
  type vcvtop = Splat
  type cvtop = (vcvtop, vcvtop, vcvtop, vcvtop, vcvtop, vcvtop, vcvtop) v128op
  type extract =
      extension (* used for extracting I8 and I16 *)
    * int       (* lane index *)
  type extractop = (extract, extract, extract, extract, extract, extract, extract) v128op
  type replaceop = (int, int, int, int, int, int, int) v128op
  type shift = Shl | ShrS | ShrU
  type shiftop = (shift, shift, shift, shift, shift, shift, shift) v128op
  type bitmask = Bitmask
  type bitmaskop = (bitmask, bitmask, bitmask, bitmask, bitmask, bitmask, bitmask) v128op
end

module I32Op = IntOp
module I64Op = IntOp
module F32Op = FloatOp
module F64Op = FloatOp
module V128Op = SimdOp

type unop = (I32Op.unop, I64Op.unop, F32Op.unop, F64Op.unop, V128Op.unop) Values.op
type binop = (I32Op.binop, I64Op.binop, F32Op.binop, F64Op.binop, V128Op.binop) Values.op
type testop = (I32Op.testop, I64Op.testop, F32Op.testop, F64Op.testop, V128Op.testop) Values.op
type relop = (I32Op.relop, I64Op.relop, F32Op.relop, F64Op.relop, V128Op.relop) Values.op
type cvtop = (I32Op.cvtop, I64Op.cvtop, F32Op.cvtop, F64Op.cvtop, V128Op.cvtop) Values.op
type extractop = V128Op.extractop
type replaceop = V128Op.replaceop
(* Ternary operators only exist for V128 types for now *)
type ternop = V128Op.ternop
type shiftop = V128Op.shiftop
type bitmaskop = V128Op.bitmaskop

type 'a memop =
  {ty : value_type; align : int; offset : Memory.offset; sz : 'a option}
type loadop = (pack_size * extension) memop
type storeop = pack_size memop

type simd_loadop = (pack_size * pack_simd) memop
type empty
type simd_storeop = empty memop

(* Expressions *)

type var = int32 Source.phrase
type literal = Values.value Source.phrase
type name = int list

type block_type = VarBlockType of var | ValBlockType of value_type option

type instr = instr' Source.phrase
and instr' =
  | Unreachable                       (* trap unconditionally *)
  | Nop                               (* do nothing *)
  | Drop                              (* forget a value *)
  | Select                            (* branchless conditional *)
  | Block of block_type * instr list  (* execute in sequence *)
  | Loop of block_type * instr list   (* loop header *)
  | If of block_type * instr list * instr list  (* conditional *)
  | Br of var                         (* break to n-th surrounding label *)
  | BrIf of var                       (* conditional break *)
  | BrTable of var list * var         (* indexed break *)
  | Return                            (* break from function body *)
  | Call of var                       (* call function *)
  | CallIndirect of var               (* call function through table *)
  | LocalGet of var                   (* read local variable *)
  | LocalSet of var                   (* write local variable *)
  | LocalTee of var                   (* write local variable and keep value *)
  | GlobalGet of var                  (* read global variable *)
  | GlobalSet of var                  (* write global variable *)
  | Load of loadop                    (* read memory at address *)
  | Store of storeop                  (* write memory at address *)
  | SimdLoad of simd_loadop           (* read memory at address *)
  | SimdStore of simd_storeop         (* write memory at address *)
  | MemorySize                        (* size of linear memory *)
  | MemoryGrow                        (* grow linear memory *)
  | Const of literal                  (* constant *)
  | Test of testop                    (* numeric test *)
  | Compare of relop                  (* numeric comparison *)
  | Unary of unop                     (* unary numeric operator *)
  | Binary of binop                   (* binary numeric operator *)
  | Ternary of ternop                 (* ternary numeric operator *)
  | Convert of cvtop                  (* conversion *)
  | SimdExtract of extractop          (* extract lane from v128 value *)
  | SimdReplace of replaceop          (* replace lane of v128 value *)
  | SimdShift of shiftop              (* shifts for v128 value *)
  | SimdBitmask of bitmaskop          (* bitmask for v128 value *)


(* Globals & Functions *)

type const = instr list Source.phrase

type global = global' Source.phrase
and global' =
{
  gtype : global_type;
  value : const;
}

type func = func' Source.phrase
and func' =
{
  ftype : var;
  locals : value_type list;
  body : instr list;
}


(* Tables & Memories *)

type table = table' Source.phrase
and table' =
{
  ttype : table_type;
}

type memory = memory' Source.phrase
and memory' =
{
  mtype : memory_type;
}

type 'data segment = 'data segment' Source.phrase
and 'data segment' =
{
  index : var;
  offset : const;
  init : 'data;
}

type table_segment = var list segment
type memory_segment = string segment


(* Modules *)

type type_ = func_type Source.phrase

type export_desc = export_desc' Source.phrase
and export_desc' =
  | FuncExport of var
  | TableExport of var
  | MemoryExport of var
  | GlobalExport of var

type export = export' Source.phrase
and export' =
{
  name : name;
  edesc : export_desc;
}

type import_desc = import_desc' Source.phrase
and import_desc' =
  | FuncImport of var
  | TableImport of table_type
  | MemoryImport of memory_type
  | GlobalImport of global_type

type import = import' Source.phrase
and import' =
{
  module_name : name;
  item_name : name;
  idesc : import_desc;
}

type module_ = module_' Source.phrase
and module_' =
{
  types : type_ list;
  globals : global list;
  tables : table list;
  memories : memory list;
  funcs : func list;
  start : var option;
  elems : var list segment list;
  data : string segment list;
  imports : import list;
  exports : export list;
}


(* Auxiliary functions *)

let empty_module =
{
  types = [];
  globals = [];
  tables = [];
  memories = [];
  funcs = [];
  start = None;
  elems  = [];
  data = [];
  imports = [];
  exports = [];
}

open Source

let func_type_for (m : module_) (x : var) : func_type =
  (Lib.List32.nth m.it.types x.it).it

let import_type (m : module_) (im : import) : extern_type =
  let {idesc; _} = im.it in
  match idesc.it with
  | FuncImport x -> ExternFuncType (func_type_for m x)
  | TableImport t -> ExternTableType t
  | MemoryImport t -> ExternMemoryType t
  | GlobalImport t -> ExternGlobalType t

let export_type (m : module_) (ex : export) : extern_type =
  let {edesc; _} = ex.it in
  let its = List.map (import_type m) m.it.imports in
  let open Lib.List32 in
  match edesc.it with
  | FuncExport x ->
    let fts =
      funcs its @ List.map (fun f -> func_type_for m f.it.ftype) m.it.funcs
    in ExternFuncType (nth fts x.it)
  | TableExport x ->
    let tts = tables its @ List.map (fun t -> t.it.ttype) m.it.tables in
    ExternTableType (nth tts x.it)
  | MemoryExport x ->
    let mts = memories its @ List.map (fun m -> m.it.mtype) m.it.memories in
    ExternMemoryType (nth mts x.it)
  | GlobalExport x ->
    let gts = globals its @ List.map (fun g -> g.it.gtype) m.it.globals in
    ExternGlobalType (nth gts x.it)

let string_of_name n =
  let b = Buffer.create 16 in
  let escape uc =
    if uc < 0x20 || uc >= 0x7f then
      Buffer.add_string b (Printf.sprintf "\\u{%02x}" uc)
    else begin
      let c = Char.chr uc in
      if c = '\"' || c = '\\' then Buffer.add_char b '\\';
      Buffer.add_char b c
    end
  in
  List.iter escape n;
  Buffer.contents b
