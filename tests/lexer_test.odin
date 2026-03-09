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
		{".", ".", token.Symbol.DOT},
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
		{"\"", "\"", token.Symbol.QUOTE},
		{"'", "'", token.Symbol.QUOTE},
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
	input := "'#$*(&)"
	test_cases := []struct {
		expected_literal: string,
		expected_type:    token.Symbol,
	} {
		{"'", token.Symbol.QUOTE},
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
		{"1", "1", token.DataType.NUMBER},
		{"2", "2", token.DataType.NUMBER},
		{"3", "3", token.DataType.NUMBER},
		{"4", "4", token.DataType.NUMBER},
		{"5", "5", token.DataType.NUMBER},
		{"6", "6", token.DataType.NUMBER},
		{"7", "7", token.DataType.NUMBER},
		{"8", "8", token.DataType.NUMBER},
		{"9", "9", token.DataType.NUMBER},
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
	input := "12345 786 1 89"
	test_cases := []struct {
		expected_literal: string,
		expected_type:    token.DataType,
	} {
		{"12345", token.DataType.NUMBER},
		{"786", token.DataType.NUMBER},
		{"1", token.DataType.NUMBER},
		{"89", token.DataType.NUMBER},
	}

	l := lexer.new(input)

	for tc in test_cases {
		tok := lexer.get_next_token(&l)
		testing.expect_value(t, tok.literal, tc.expected_literal)
		testing.expect_value(t, tok.type, tc.expected_type)
	}
}
