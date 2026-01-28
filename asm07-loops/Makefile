
PROGS = loop nestloop
OBJS = loop.o nestloop.o

all: $(PROGS)

loop: loop.o
	ld loop.o -o loop

loop.o: loop.asm
	nasm -f elf64 loop.asm -o loop.o

nestloop: nestloop.o
	ld nestloop.o -o nestloop

nestloop.o: nestloop.asm
	nasm -f elf64 nestloop.asm -o nestloop.o

test: $(PROGS)
	./loop
	./nestloop

clean:
	rm -f $(PROGS) $(OBJS) *~
