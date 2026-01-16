

hello: hello.o
	ld hello.o -o hello

hello.o: hello.asm
	nasm -f elf64 hello.asm -o hello.o

test: hello
	./hello

clean:
	rm -f hello hello.o *~
