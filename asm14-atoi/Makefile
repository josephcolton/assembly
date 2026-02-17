

atoi: atoi.o
	ld atoi.o -o atoi

atoi.o: atoi.asm
	nasm -f elf64 atoi.asm -o atoi.o

test: atoi
	./atoi

clean:
	rm -f atoi atoi.o *~
