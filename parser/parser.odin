package parser

import "../ast"
import "../lexer"
import "../token"
import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"


Parser :: struct {
	lexer:         ^lexer.Lexer,
	current_token: token.Token,
	peek_token:    token.Token,
	error_msg:     string,
}

@(private = "file")
next_token :: proc(p: ^Parser) {
	p.current_token = p.peek_token
	p.peek_token = lexer.get_next_token(p.lexer)
}

new :: proc(l: ^lexer.Lexer) -> Parser {
	p := Parser {
		lexer = l,
	}
	next_token(&p) // set peek token
	next_token(&p) // set current token

	return p
}

parse_program :: proc(p: ^Parser) -> ast.Program {
	program: ast.Program

	stmt_loop: for p.current_token.type != token.Symbol.EOF {
		if p.current_token.type == token.Symbol.ILLEGAL {
			fmt.printfln(
				"Illegal token on line %d, column %d: '%s'",
				p.current_token.line,
				p.current_token.column,
				p.current_token.literal,
			)
			os.exit(1)
		}

		stmt := parse_statement(p)

		// check for errors
		if p.error_msg != "" {
			break stmt_loop
		}

		if stmt != nil {
			append(&program.Statements, stmt)
		}
		next_token(p)
	}

	return program
}

@(private = "file")
parse_statement :: proc(p: ^Parser) -> ast.Statement {
	switch p.current_token.type {
	case token.Keyword.LET:
		return parse_var_bind(p)

	case token.Keyword.FUNCTION:
		return parse_fn_def(p)

	case:
		syntax_error(p, []token.TokenType{token.Keyword.LET, token.Keyword.FUNCTION})
		return nil
	}
}

@(private = "file")
parse_var_bind :: proc(p: ^Parser) -> ast.VarBind {
	bind: ast.VarBind
	// next_token(p) // consume LET

	tok, ok := expect_peek(p, []token.TokenType{token.DataType.IDENTIFIER})
	if !ok {
		return bind
	}
	bind.Identifier = tok.literal

	_, ok = expect_peek(p, []token.TokenType{token.Symbol.ASSIGNMENT})
	if !ok {
		return bind
	}

	_, ok = expect_peek(
		p,
		[]token.TokenType{token.DataType.INTEGER, token.DataType.FLOAT, token.DataType.STRING},
	)
	if !ok {
		return bind
	}

	bind.Value = parse_value(p)
	return bind
}

@(private = "file")
parse_value :: proc(p: ^Parser) -> ast.Value {
	switch p.current_token.type {
	case token.DataType.INTEGER:
		val, _ := strconv.parse_i64(p.current_token.literal)
		return val

	case token.DataType.FLOAT:
		val, _ := strconv.parse_f64(p.current_token.literal)
		return val

	case token.DataType.STRING:
		return ast.Value(p.current_token.literal)

	case:
		return nil
	}
}

syntax_error :: proc(p: ^Parser, expected: []token.TokenType) {
	p.error_msg = fmt.tprintf(
		"Syntax Error on line %d, column %d: expected %v, got %v",
		p.peek_token.line,
		p.peek_token.column,
		expected,
		p.peek_token.type,
	)
}

@(private = "file")
expect_peek :: proc(p: ^Parser, expected: []token.TokenType) -> (token.Token, bool) {
	tok := p.peek_token

	// Check if token is illegal
	if tok.type == token.Symbol.ILLEGAL {
		p.error_msg = fmt.tprintf(
			"Illegal token on line %d, column %d: '%s'",
			tok.line,
			tok.column,
			tok.literal,
		)
		// Skip illegal token to recover
		next_token(p)
		return tok, false
	}

	// Check if token is one of expected types
	ok := slice.any_of(expected, tok.type)
	if !ok {
		syntax_error(p, expected)
	}
	next_token(p)
	return tok, ok
}

@(private = "file")
parse_fn_def :: proc(p: ^Parser) -> ast.FnDef {return ast.FnDef{}}

// @(private = "file")
// parse_param :: proc() -> ast.Param {}

// @(private = "file")
// parse_param_list :: proc() -> [dynamic]ast.Param {}

// @(private = "file")
// parse_block :: proc() -> ast.Block {}

// @(private = "file")
// parse_return_stmt :: proc() -> ast.ReturnStmt {}

// @(private = "file")
// parse_type :: proc() -> ast.Type {}
