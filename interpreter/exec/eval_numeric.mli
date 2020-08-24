open Values

exception TypeError of int * value * Types.value_type

val eval_unop : Ast.unop -> value -> value
val eval_binop : Ast.binop -> value -> value -> value
val eval_testop : Ast.testop -> value -> bool
val eval_relop : Ast.relop -> value -> value -> bool
val eval_cvtop : Ast.cvtop -> value -> value
val eval_extractop : Ast.extractop -> value -> value
val eval_replaceop : Ast.replaceop -> value -> value -> value
val eval_ternop : Ast.ternop -> value -> value -> value -> value
val eval_shiftop : Ast.shiftop -> value -> value -> value
val eval_bitmaskop : Ast.bitmaskop -> value -> value
