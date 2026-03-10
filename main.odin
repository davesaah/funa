package main

import "core:bufio"
import "core:fmt"
import "core:io"
import "core:os"
import "lexer"
import "token"

main :: proc() {
	args := os.args

	if len(args) < 3 {
		fmt.println("Usage: funa run <filename>")
		os.exit(1)
	}

	cmd, filename := args[1], args[2]
	f, open_err := os.open(filename)

	if open_err != os.ERROR_NONE {
		fmt.eprintfln("Error: could not open '%s': %v", filename, open_err)
		os.exit(1)
	}
	defer os.close(f)

	reader: bufio.Reader
	bufio.reader_init(&reader, os.stream_from_handle(f))
	defer bufio.reader_destroy(&reader)

	switch cmd {
	case "run":
		for {
			line, read_err := bufio.reader_read_string(&reader, '\n')
			defer delete(line)

			if read_err == io.Error.EOF {
				break
			}

			if read_err != nil {
				fmt.eprintfln("Error: failed to read from '%s': %v", filename, read_err)
				os.exit(1)
			}

			run_lexer(line)
		}
	}
}

run_lexer :: proc(s: string) {
	l := lexer.new(s)

	for tok := lexer.get_next_token(&l);
	    tok.type != token.Symbol.EOF;
	    tok = lexer.get_next_token(&l) {
		fmt.println(tok)
	}
}
