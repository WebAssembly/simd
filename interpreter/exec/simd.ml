open Char

type shape = I8x16 | I16x8 | I32x4 | I64x2 | F32x4 | F64x2

let lanes shape =
  match shape with
  | I8x16 -> 16
  | I16x8 -> 8
  | I32x4 -> 4
  | I64x2 -> 2
  | F32x4 -> 4
  | F64x2 -> 2

let f32x4_indices = [0; 4; 8; 12]
let f64x2_indices = [0; 8]

module type RepType =
sig
  type t

  val make : int -> char -> t
  (* ^ bits_make ? *)
  val to_string : t -> string
  val bytewidth : int
  val of_strings : shape -> string list -> t

  val to_i32x4 : t -> I32.t list

  val to_f32x4 : t -> F32.t list
  val of_f32x4 : F32.t list -> t

  val to_f64x2 : t -> F64.t list
  val of_f64x2 : F64.t list -> t
end

module type S =
sig
  type t
  type bits
  val default : t (* FIXME good name for default value? *)
  val to_string : t -> string
  val of_bits : bits -> t
  val to_bits : t -> bits
  val of_strings : shape -> string list -> t

  val i32x4_extract_lane : int -> t -> I32.t

  val f32x4_extract_lane : int -> t -> F32.t

  val f64x2_extract_lane : int -> t -> F64.t

  module type Shape =
  sig
    type u
    val unop : (u -> u) -> t -> t

    val abs : t -> t
    val min : t -> t -> t
    val max : t -> t -> t
  end

  module F32x4 : Shape
  module F64x2 : Shape
end

module Make (Rep : RepType) : S with type bits = Rep.t =
struct
  type t = Rep.t
  type bits = Rep.t

  let default = Rep.make Rep.bytewidth (chr 0)
  let to_string = Rep.to_string (* FIXME very very wrong *)
  let of_bits x = x
  let to_bits x = x
  let of_strings = Rep.of_strings

  let to_i32x4 = Rep.to_i32x4

  let i32x4_extract_lane i x = List.nth (to_i32x4 x) i

  let to_f32x4 = Rep.to_f32x4

  let f32x4_extract_lane i x = List.nth (to_f32x4 x) i

  let to_f64x2 = Rep.to_f64x2

  let f64x2_extract_lane i x = List.nth (to_f64x2 x) i

  module type Shape =
  sig
    type u
    val unop : (u -> u) -> t -> t

    val abs : t -> t
    val min : t -> t -> t
    val max : t -> t -> t
  end

  module F32x4 : Shape =
  struct
      type u = F32.t

      let to_shape = Rep.to_f32x4
      let of_shape = Rep.of_f32x4
      let unop f x = of_shape (List.map f (to_shape x))
      let binop f x y = of_shape (List.map2 f (to_shape x) (to_shape y))

      let abs = unop F32.abs
      let min = binop F32.min
      let max = binop F32.max
  end

  module F64x2 : Shape =
  struct
      type u = F64.t

      let to_shape = Rep.to_f64x2
      let of_shape = Rep.of_f64x2
      let unop f x = of_shape (List.map f (to_shape x))
      let binop f x y = of_shape (List.map2 f (to_shape x) (to_shape y))

      let abs = unop F64.abs
      let min = binop F64.min
      let max = binop F64.max
  end

end
