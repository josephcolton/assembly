
PROGS = hello2 printchar
OBJS = hello2.o printchar.o

all: $(PROGS)

hello2: hello2.o
	ld hello2.o -o hello2

hello2.o: hello2.asm
	nasm -f elf64 hello2.asm -o hello2.o

printchar: printchar.o
	ld printchar.o -o printchar

printchar.o: printchar.asm
	nasm -f elf64 printchar.asm -o printchar.o

test: $(PROGS)
	./hello2
	./printchar

clean:
	rm -f $(PROGS) $(OBJS) *~
