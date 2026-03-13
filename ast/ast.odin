package ast

Program :: struct {
	Statements: [dynamic]Statement,
}

Statement :: union {
	VarBind,
	FnDef,
}

VarBind :: struct {
	Identifier: string,
	Value:      Value,
}

Param :: struct {
	Identifier: string,
	Type:       Type,
}

Block :: struct {
	Statements: [dynamic]Statement,
	Return:     ReturnStmt,
}

FnDef :: struct {
	Identifier: string,
	Params:     [dynamic]Param,
	Body:       Block,
	ReturnType: Type,
}

Value :: union {
	f64,
	i64,
	string,
}

Type :: enum {
	INTEGER,
	FLOAT,
	STRING,
}

ReturnStmt :: union {
	Value,
	VarBind,
}
