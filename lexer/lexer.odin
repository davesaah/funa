package lexer

import "../token"
import "core:strings"

Lexer :: struct {
	input:            string,
	current_char:     byte,
	current_position: int,
	next_position:    int,
	line:             int,
	column:           int,
}

new :: proc(input: string) -> Lexer {
	l := Lexer {
		input = input,
		line  = 1,
	}

	read_next_char(&l) // set l.current_char to the first one

	return l
}

get_next_token :: proc(l: ^Lexer) -> token.Token {
	// remove whitespaces
	for is_whitespace(l.current_char) {
		read_next_char(l)
	}

	start := l.current_position
	start_line := l.line
	start_column := l.column

	tok := token.Token{}

	switch l.current_char {
	case ',':
		tok.type = token.Symbol.COMMA
	case ':':
		tok.type = token.Symbol.COLON
	case '_':
		tok.type = token.Symbol.UNDERSCORE
	case '|':
		tok.type = token.Symbol.PIPE
	case '#':
		tok.type = token.Symbol.BANG
	case '/':
		tok.type = token.Symbol.SLASH
	case '*':
		tok.type = token.Symbol.ASTERISK
	case '<':
		tok.type = token.Symbol.LESS_THAN
	case '>':
		tok.type = token.Symbol.GREATER_THAN
	case '[':
		tok.type = token.Symbol.LBRACE
	case ']':
		tok.type = token.Symbol.RBRACE
	case '(':
		tok.type = token.Symbol.LPAREN
	case ')':
		tok.type = token.Symbol.RPAREN
	case '{':
		tok.type = token.Symbol.LCURLY
	case '}':
		tok.type = token.Symbol.RCURLY
	case '"', '\'':
		opening_quote := l.current_char
		read_next_char(l) // skip opening quote
		start = l.current_position
		for l.current_char != opening_quote && l.current_char != 0 {
			read_next_char(l)
		}
		tok.type = token.DataType.STRING
		tok.literal = l.input[start:l.current_position]
		tok.line = start_line
		tok.column = start_column
		read_next_char(l) // skip closing quote
		return tok
	case 0:
		tok.type = token.Symbol.EOF
		tok.line = start_line
		tok.column = start_column
		return tok
	case '=':
		if peek_char(l) == '=' {
			read_next_char(l)
			tok.type = token.Symbol.EQUALS
		} else {
			tok.type = token.Symbol.ASSIGNMENT
		}
	case '!':
		if peek_char(l) == '=' {
			read_next_char(l)
			tok.type = token.Symbol.NOT_EQUALS
		} else {
			tok.type = token.Symbol.ILLEGAL
		}
	case:
		if is_number(l.current_char) {
			for is_number(l.current_char) {
				read_next_char(l)
			}

			tok.literal = l.input[start:l.current_position]

			if strings.contains(tok.literal, ".") {
				tok.type = token.DataType.FLOAT
			} else {
				tok.type = token.DataType.INTEGER
			}
			tok.line = start_line
			tok.column = start_column
			return tok
		} else if is_letter(l.current_char) {
			for is_letter(l.current_char) || is_number(l.current_char) {
				read_next_char(l)
			}
			tok.literal = l.input[start:l.current_position]
			tok.type = token.lookup_identifier(tok.literal) // identifier or keyword
			tok.line = start_line
			tok.column = start_column
			return tok
		} else {
			tok.type = token.Symbol.ILLEGAL
		}
	}

	tok.literal = l.input[start:l.current_position + 1]
	tok.line = start_line
	tok.column = start_column
	read_next_char(l)
	return tok
}

@(private = "file")
read_next_char :: proc(l: ^Lexer) {
	if l.next_position >= len(l.input) {
		l.current_char = 0 // ASCII NULL
		l.current_position = len(l.input)
		return
	}

	l.current_char = l.input[l.next_position]
	l.current_position = l.next_position
	l.next_position += 1

	// Track line and column correctly
	if l.current_char == '\n' {
		l.line += 1
		l.column = 0
	} else {
		l.column += 1
	}
}


@(private = "file")
is_whitespace :: proc(c: byte) -> bool {
	return c == ' ' || c == '\t' || c == '\n' || c == '\r'
}

@(private = "file")
peek_char :: proc(l: ^Lexer) -> byte {
	if l.next_position >= len(l.input) {
		return 0
	}
	return l.input[l.next_position]
}

@(private = "file")
is_number :: proc(c: byte) -> bool {
	return (c >= '0' && c <= '9') || (c == '.')
}

@(private = "file")
is_letter :: proc(c: byte) -> bool {
	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_'
}
