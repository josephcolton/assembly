
PROGS = toupper sum
OBJS = toupper.o sum.o

all: $(PROGS)

toupper: toupper.o
	ld toupper.o -o toupper

toupper.o: toupper.asm
	nasm -f elf64 toupper.asm -o toupper.o

sum: sum.o
	ld sum.o -o sum

sum.o: sum.asm
	nasm -f elf64 sum.asm -o sum.o

test: $(PROGS)
	./toupper
	./sum

clean:
	rm -f $(PROGS) $(OBJS) *~
