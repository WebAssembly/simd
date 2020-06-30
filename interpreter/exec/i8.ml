(* I8 for SIMD. Uses Int32 as the underlying storage. All int8 values will be
 * stored signed-extended. E.g. -1 will be stored with all high bits set.
 *)
include Int.Make (struct
  include Int32

  let bitwidth = 8
  (* TODO incorrect for negative values. *)
  let to_hex_string = Printf.sprintf "%lx"

  let of_int64 = Int64.to_int32
  let to_int64 = Int64.of_int32
end)
