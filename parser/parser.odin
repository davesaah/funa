package parser

import "../ast"
import "../lexer"
import "../token"
import "core:fmt"
import "core:strconv"


Parser :: struct {
	lexer:         ^lexer.Lexer,
	current_token: token.Token,
	errors:        [dynamic]ParserError,
}

ParserError :: struct {
	message: string,
}

@(private = "file")
next_token :: proc(p: ^Parser) {
	p.current_token = lexer.get_next_token(p.lexer)
}

new :: proc(l: ^lexer.Lexer) -> Parser {
	p := Parser {
		lexer = l,
	}
	next_token(&p) // set current token

	return p
}

parse_program :: proc(p: ^Parser) -> ast.Program {
	program: ast.Program

	for p.current_token.type != token.Symbol.EOF {
		stmt := parse_statement(p)

		if stmt != nil {
			append(&program.Statements, stmt)
		} else {
			break
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

	// case token.Keyword.FUNCTION:
	// 	return parse_fn_def(p)

	case:
		syntax_error(p, token.Keyword.LET)
		// syntax_error(p, token.Keyword.FUNCTION)
		return nil
	}
}

@(private = "file")
parse_var_bind :: proc(p: ^Parser) -> ast.VarBind {
	bind: ast.VarBind
	next_token(p) // consume LET

	if p.current_token.type != token.DataType.IDENTIFIER {
		syntax_error(p, token.DataType.IDENTIFIER)
		return bind
	}
	bind.Identifier = p.current_token.literal
	next_token(p) // consume IDENTIFIER

	if p.current_token.type != token.Symbol.ASSIGNMENT {
		syntax_error(p, token.Symbol.ASSIGNMENT)
		return bind
	}
	next_token(p) // consume ASSIGNMENT

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
		parser_error(p, "invalid value")
		return nil
	}
}


@(private = "file")
parser_error :: proc(p: ^Parser, msg: string) {
	err := ParserError {
		message = msg,
	}

	append(&p.errors, err)
}


@(private = "file")
syntax_error :: proc(p: ^Parser, expected: token.TokenType) {
	msg := fmt.tprintf(
		"Syntax Error on line %d, column %d: expected %v, got %v",
		p.current_token.line,
        p.current_token.column,
		expected,
		p.current_token.type,
	)

	parser_error(p, msg)
}

// @(private = "file")
// parse_fn_def :: proc(p: ^Parser) -> ast.FnDef {}

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
