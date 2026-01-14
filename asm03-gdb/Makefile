

text: text.o
	ld text.o -o text

text.o: text.asm
	nasm -f elf64 text.asm -o text.o

test: text
	./text

clean:
	rm -f text text.o
