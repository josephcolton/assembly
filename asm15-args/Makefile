
PROGS = args sumargs
OBJS = asmlib.o args.o sumargs.o

all: $(PROGS)

asmlib.o: asmlib.asm
	nasm -f elf64 asmlib.asm -o asmlib.o

args: args.o asmlib.o
	ld args.o asmlib.o -o args

args.o: args.asm
	nasm -f elf64 args.asm -o args.o

sumargs: sumargs.o asmlib.o
	ld sumargs.o asmlib.o -o sumargs

sumargs.o: sumargs.asm
	nasm -f elf64 sumargs.asm -o sumargs.o

test: $(PROGS)
	./args arg1 arg2 arg3 arg4
	./sumargs 123 456

clean:
	rm -f $(PROGS) $(OBJS) *~
