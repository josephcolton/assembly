
PROGS = readfile writefile
OBJS = readfile.o writefile.o

all: $(PROGS)

readfile: readfile.o
	ld readfile.o -o readfile

readfile.o: readfile.asm
	nasm -f elf64 readfile.asm -o readfile.o

writefile: writefile.o
	ld writefile.o -o writefile

writefile.o: writefile.asm
	nasm -f elf64 writefile.asm -o writefile.o

test: $(PROGS)
	./readfile
	./writefile

clean:
	rm -f $(PROGS) $(OBJS) *~ outfile.txt

