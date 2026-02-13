
PROGS = printtest pascal
OBJS = asmlib.o printtest.o pascal.o

all: $(PROGS)

asmlib.o: asmlib.asm
	nasm -f elf64 asmlib.asm -o asmlib.o

printtest: printtest.o asmlib.o
	ld printtest.o asmlib.o -o printtest

printtest.o: printtest.asm
	nasm -f elf64 printtest.asm -o printtest.o

pascal: pascal.o asmlib.o
	ld pascal.o asmlib.o -o pascal

pascal.o: pascal.asm
	nasm -f elf64 pascal.asm -o pascal.o

test: $(PROGS)
	./printtest
	./pascal

clean:
	rm -f $(PROGS) $(OBJS) *~
