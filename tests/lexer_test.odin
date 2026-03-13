package lexer_test

import "../lexer"
import "../token"
import "core:testing"

@(test)
get_next_token_symbols_single :: proc(t: ^testing.T) {
	// Table of (input, expected literal, expected token type)
	test_cases := []struct {
		input:            string,
		expected_literal: string,
		expected_type:    token.Symbol,
	} {
		{"=", "=", token.Symbol.ASSIGNMENT},
		{"!=", "!=", token.Symbol.NOT_EQUALS},
		{"==", "==", token.Symbol.EQUALS},
		{",", ",", token.Symbol.COMMA},
		{":", ":", token.Symbol.COLON},
		{"_", "_", token.Symbol.UNDERSCORE},
		{"|", "|", token.Symbol.PIPE},
		{";", ";", token.Symbol.SEMI_COLON},
		{"#", "#", token.Symbol.BANG},
		{"/", "/", token.Symbol.SLASH},
		{"*", "*", token.Symbol.ASTERISK},
		{"<", "<", token.Symbol.LESS_THAN},
		{">", ">", token.Symbol.GREATER_THAN},
		{"[", "[", token.Symbol.LBRACE},
		{"]", "]", token.Symbol.RBRACE},
		{"(", "(", token.Symbol.LPAREN},
		{")", ")", token.Symbol.RPAREN},
		{"{", "{", token.Symbol.LCURLY},
		{"}", "}", token.Symbol.RCURLY},
	}

	for tc in test_cases {
		// Initialize a fresh lexer for each case
		l := lexer.new(tc.input)

		tok := lexer.get_next_token(&l)

		// Expect literal and type
		testing.expect_value(t, tok.literal, tc.expected_literal)
		testing.expect_value(t, tok.type, tc.expected_type)
	}
}


@(test)
get_next_token_symbols_multiple :: proc(t: ^testing.T) {
	input := "#$*(&)"
	test_cases := []struct {
		expected_literal: string,
		expected_type:    token.Symbol,
	} {
		{"#", token.Symbol.BANG},
		{"$", token.Symbol.ILLEGAL},
		{"*", token.Symbol.ASTERISK},
		{"(", token.Symbol.LPAREN},
		{"&", token.Symbol.ILLEGAL},
		{")", token.Symbol.RPAREN},
	}

	l := lexer.new(input)

	for tc in test_cases {
		tok := lexer.get_next_token(&l)
		testing.expect_value(t, tok.literal, tc.expected_literal)
		testing.expect_value(t, tok.type, tc.expected_type)
	}
}


@(test)
get_next_token_datatypes_single :: proc(t: ^testing.T) {
	// Table of (input, expected literal, expected token type)
	test_cases := []struct {
		input:            string,
		expected_literal: string,
		expected_type:    token.DataType,
	} {
		{"2", "2", token.DataType.INTEGER},
		{"3", "3", token.DataType.INTEGER},
		{"1", "1", token.DataType.INTEGER},
		{"4", "4", token.DataType.INTEGER},
		{"5", "5", token.DataType.INTEGER},
		{"6.3", "6.3", token.DataType.FLOAT},
		{".7", ".7", token.DataType.FLOAT},
		{"8.5", "8.5", token.DataType.FLOAT},
		{"9.0", "9.0", token.DataType.FLOAT},
	}

	for tc in test_cases {
		// Initialize a fresh lexer for each case
		l := lexer.new(tc.input)

		tok := lexer.get_next_token(&l)

		// Expect literal and type
		testing.expect_value(t, tok.literal, tc.expected_literal)
		testing.expect_value(t, tok.type, tc.expected_type)
	}
}


@(test)
get_next_token_datatypes_multiple :: proc(t: ^testing.T) {
	input := "12345 786 1 8.9 'Hello World' \"Some\""
	test_cases := []struct {
		expected_literal: string,
		expected_type:    token.DataType,
	} {
		{"12345", token.DataType.INTEGER},
		{"786", token.DataType.INTEGER},
		{"1", token.DataType.INTEGER},
		{"8.9", token.DataType.FLOAT},
		{"Hello World", token.DataType.STRING},
		{"Some", token.DataType.STRING},
	}

	l := lexer.new(input)

	for tc in test_cases {
		tok := lexer.get_next_token(&l)
		testing.expect_value(t, tok.literal, tc.expected_literal)
		testing.expect_value(t, tok.type, tc.expected_type)
	}
}


get_next_token_identifiers_single :: proc(t: ^testing.T) {
	test_cases := []struct {
		input:            string,
		expected_literal: string,
		expected_type:    token.TokenType,
	} {
		{"let", "let", token.Keyword.LET},
		{"using", "using", token.Keyword.USING},
		{"function", "function", token.Keyword.FUNCTION},
		{"return", "return", token.Keyword.RETURN},
		{"some", "some", token.DataType.IDENTIFIER},
		{"two_people", "two_people", token.DataType.IDENTIFIER},
		{"toe_4", "toe_4", token.DataType.IDENTIFIER},
	}

	for tc in test_cases {
		// Initialize a fresh lexer for each case
		l := lexer.new(tc.input)

		tok := lexer.get_next_token(&l)

		// Expect literal and type
		testing.expect_value(t, tok.literal, tc.expected_literal)
		testing.expect_value(t, tok.type, tc.expected_type)
	}
}
