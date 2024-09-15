SHELL := /bin/bash

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

emsdk:
	@echo "Downloading EMSDK..."
	@git clone https://github.com/emscripten-core/emsdk.git
	@cd emsdk && ./emsdk install latest && ./emsdk activate latest

setup:
	@echo "Setting up directories..."
	@mkdir -p tmp
	@mkdir -p lib
	@mkdir -p dist
	if [ ! -d "emsdk" ]; then $(MAKE) emsdk; fi
	@echo "Configuring EMSDK..."
	@source $(CURDIR)/emsdk/emsdk_env.sh

.PHONY: build setup libs