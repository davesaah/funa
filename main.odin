package main

import "core:fmt"
import "lexer"

main :: proc() {
	l := lexer.new("==")
	tok := lexer.get_next_token(&l)
	fmt.println(tok.literal)
}
