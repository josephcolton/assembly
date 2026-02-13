
PROGS = factorial factorial2
OBJS = factorial.o factorial2.o

all: $(PROGS)

factorial: factorial.o
	ld factorial.o -o factorial

factorial.o: factorial.asm
	nasm -f elf64 factorial.asm -o factorial.o

factorial2: factorial2.o
	ld factorial2.o -o factorial2

factorial2.o: factorial2.asm
	nasm -f elf64 factorial2.asm -o factorial2.o

test: factorial
	./factorial

test2: factorial2
	./factorial2

clean:
	rm -f $(PROGS) $(OBJS) *~
