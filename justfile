test:
	@odin test tests

build:
	@odin build .

run: build
	@./funa run examples/sample.funa
	@rm funa
