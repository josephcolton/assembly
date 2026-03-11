
PROGS = copy
OBJS = copy.o

all: $(PROGS)

copy: copy.o
	ld copy.o -o copy

copy.o: copy.asm
	nasm -f elf64 copy.asm -o copy.o

test: $(PROGS)
	echo "Hello" > source.txt
	./copy source.txt destination.txt

clean:
	rm -f $(PROGS) $(OBJS) *.txt *~

