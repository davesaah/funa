test:
	@odin test tests

build:
	@odin build . -debug -out:bin/funa

release:
	@odin build . -o:speed -out:bin/funa

debug: build
	@gdb ./bin/funa

run: build
	@./bin/funa run examples/sample.funa
	@rm ./bin/funa