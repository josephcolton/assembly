
PROGS = ifstatement
OBJS = ifstatement.o

ifstatement: ifstatement.o
	ld ifstatement.o -o ifstatement

ifstatement.o: ifstatement.asm
	nasm -f elf64 ifstatement.asm -o ifstatement.o

test: $(PROGS)
	./ifstatement

debug: $(PROGS)
	gdb ifstatement

clean:
	rm -f $(PROGS) $(OBJS) *~
