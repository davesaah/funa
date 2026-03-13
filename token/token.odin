package token

TokenType :: union {
	Symbol,
	DataType,
	Keyword,
}

Token :: struct {
	literal: string,
	type:    TokenType,
}

Symbol :: enum {
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
}

DataType :: enum {
	INTEGER,
	FLOAT,
	STRING,
	IDENTIFIER,
}

Keyword :: enum {
	USING,
	FUNCTION,
	LET,
	MAIN,
	RETURN,
}

lookup_identifier :: proc(s: string) -> TokenType {
	switch s {
	case "using":
		return Keyword.USING
	case "function":
		return Keyword.FUNCTION
	case "let":
		return Keyword.LET
	case "main":
		return Keyword.MAIN
	case "return":
		return Keyword.RETURN
	case:
		return DataType.IDENTIFIER
	}
}
