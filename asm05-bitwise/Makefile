
PROGS = bitwise
OBJS = bitwise.o

bitwise: bitwise.o
	ld bitwise.o -o bitwise

bitwise.o: bitwise.asm
	nasm -f elf64 bitwise.asm -o bitwise.o

test: $(PROGS)
	./bitwise

debug: $(PROGS)
	gdb bitwise

clean:
	rm -f $(PROGS) $(OBJS) *~
