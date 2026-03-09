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
	ASSIGNMENT,
	EQUALS,
	NOT_EQUALS,
	SLASH,
	ASTERISK,
	LESS_THAN,
	GREATER_THAN,
	LBRACE,
	RBRACE,
	LPAREN,
	RPAREN,
	LCURLY,
	RCURLY,
	ILLEGAL,
	EOF,
	QUOTE,
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
