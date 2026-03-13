
PROGS = stat
OBJS = asmlib.o stat.o

all: $(PROGS)

asmlib.o: asmlib.asm
	nasm -f elf64 asmlib.asm -o asmlib.o

stat: stat.o asmlib.o
	ld stat.o asmlib.o -o stat

stat.o: stat.asm
	nasm -f elf64 stat.asm -o stat.o

test: $(PROGS)
	./stat stat.asm
	./stat stat
	./stat .

clean:
	rm -f $(PROGS) $(OBJS) *~
