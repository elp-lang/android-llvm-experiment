.PHONY: build

build:
	mkdir -p ./app/build/intermediates/llvm || true
	llvm-as hello_world.ll -o ./app/build/intermediates/llvm/hello_world.bc
	llvm-link ./app/build/intermediates/llvm/hello_world.bc -o ./app/build/intermediates/llvm/hello_world.o

