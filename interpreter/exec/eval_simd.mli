open Values

exception TypeError of int * value * Types.value_type

val unop : Ast.V128Op.unop -> value -> value

val binop : Ast.V128Op.binop -> value -> value -> value

val testop : Ast.V128Op.testop -> value -> bool

val relop : Ast.V128Op.relop -> value -> value -> bool

val cvtop : Ast.V128Op.cvtop -> value -> value

val eval_extractop : Ast.V128Op.extractop -> value -> value
