package main

import "core:bufio"
import "core:fmt"
import "core:io"
import "core:mem"
import "core:os"
import "lexer"
import "token"

main :: proc() {
	track: mem.Tracking_Allocator
	mem.tracking_allocator_init(&track, context.allocator)
	track.bad_free_callback = mem.tracking_allocator_bad_free_callback_add_to_array
	defer mem.tracking_allocator_destroy(&track)
	context.allocator = mem.tracking_allocator(&track)

	run() // main program

	// check for memory leaks
	for _, leak in track.allocation_map {
		fmt.printfln("\non line %d, leaked %m", leak.location.line, leak.size)
	}

	// check for bad frees
	for entry in track.bad_free_array {
		fmt.printfln("\nbad free at line %d", entry.location.line)
	}
}

run :: proc() {
	args := os.args

	if len(args) < 3 {
		fmt.println("Usage: funa run <filename>")
		os.exit(1)
	}

	cmd, filename := args[1], args[2]
	f, open_err := os.open(filename)
	defer os.close(f)

	if open_err != os.ERROR_NONE {
		fmt.eprintfln("Error: could not open '%s': %v", filename, open_err)
		os.exit(1)
	}

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
