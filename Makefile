build: setup libs
	@echo "Building..."
	@emcc -O3 -sWASM=1 -sASYNCIFY webassembly/src/main.c -Iwebassembly/include -L./lib -lExternal -o dist/emcc.js
	
	@echo "Cleaning up..."
	@rm -rf tmp
	@rm -rf lib

libs: setup lib/libExternal.a

tmp/external.o:
	@emcc -O3 webassembly/src/external.c -c -o tmp/external.o -Iwebassembly/include

lib/libExternal.a: tmp/external.o
	@echo "Creating external library..."
	@emar rcs lib/libExternal.a tmp/external.o

setup:
	@echo "Setting up directories..."
	@mkdir -p tmp
	@mkdir -p lib
	@mkdir -p dist

.PHONY: build setup libs