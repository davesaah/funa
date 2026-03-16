test:
	@odin test tests

build:
	@mkdir -p bin
	@odin build . -debug -out:bin/funa

release:
	@odin build . -o:speed -out:bin/funa

debug: build
	@gdb ./bin/funa

run: build
	@./bin/funa run examples/sample.funa
	@rm -rf bin