
PROGS = data_int data_float
OBJS = data_int.o data_float.o

all: $(PROGS)

data_int.o: data_int.asm
	nasm -f elf64 data_int.asm -o data_int.o

data_int: data_int.o
	gcc -no-pie data_int.o -o data_int

data_float.o: data_float.asm
	nasm -f elf64 data_float.asm -o data_float.o

data_float: data_float.o
	gcc -no-pie data_float.o -o data_float

test: $(PROGS)
	./data_int
	./data_float

clean:
	rm -f $(PROGS) $(OBJS) *~
