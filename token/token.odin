package token

TokenType :: union {
	Symbol,
	Identifier,
	DataType,
}

Token :: struct {
	literal: string,
	type:    TokenType,
}

Symbol :: enum {
	DOT,
	COMMA,
	COLON,
	UNDERSCORE,
	PIPE,
	SEMI_COLON,
	BANG,
	EQUAL,
	LESS_THAN,
	GREATER_THAN,
	LBRACE,
	RBRACE,
	LPAREN,
	RPAREN,
	LCURLY,
	RCURLY,
}

DataType :: enum {
	NUMBER,
	LIST,
	MAP,
	FILE,
	STRING,
}

Identifier :: enum {
	KEYWORD,
	VARIABLE,
}

// Keyword :: enum {
// 	Using,
// 	Function,
// 	Let,
// 	Main,
// 	Return,
// }

make :: proc(literal: string, type: TokenType) -> Token {
	return Token{literal, type}
}
