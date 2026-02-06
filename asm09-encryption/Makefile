
PROGS = atbash caesar
OBJS = atbash.o caesar.o

all: $(PROGS)

atbash: atbash.o
	ld atbash.o -o atbash

atbash.o: atbash.asm
	nasm -f elf64 atbash.asm -o atbash.o

caesar: caesar.o
	ld caesar.o -o caesar

caesar.o: caesar.asm
	nasm -f elf64 caesar.asm -o caesar.o

test: $(PROGS)
	./atbash
	./caesar

clean:
	rm -f $(PROGS) $(OBJS) *~
