

greeting: greeting.o
	ld greeting.o -o greeting

greeting.o: greeting.asm
	nasm -f elf64 greeting.asm -o greeting.o

test: greeting
	./greeting

clean:
	rm -f greeting greeting.o *~
