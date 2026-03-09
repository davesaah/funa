package main

import "core:fmt"
import "token"

main :: proc() {
	tok := token.make("2", token.DataType.NUMBER)
	fmt.printf("%v \n", tok)
}
