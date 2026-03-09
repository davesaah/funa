package main

import "core:fmt"
import "lexer"

main :: proc() {
	l := lexer.new("1$")
	tok := lexer.get_next_token(&l)
	fmt.println(tok)
	tok = lexer.get_next_token(&l)
	fmt.println(tok)
	tok = lexer.get_next_token(&l)
	fmt.println(tok)
}
