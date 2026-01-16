
PROGS = addsub muldiv
OBJS = addsub.o muldiv.o

addsub: addsub.o
	ld addsub.o -o addsub

addsub.o: addsub.asm
	nasm -f elf64 addsub.asm -o addsub.o

muldiv: muldiv.o
	ld muldiv.o -o muldiv

muldiv.o: muldiv.asm
	nasm -f elf64 muldiv.asm -o muldiv.o

test: $(PROGS)
	./addsub
	./muldiv

clean:
	rm -f $(PROGS) $(OBJS) *~
