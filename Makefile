hello.txt:
	echo "hello world" > hello.txt

CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-AS

%.i : %.c 
	$(CPP) $< > $@

%.s : %.i 
	$(CC) -S $@

%.o : %.s 

	$(AS) $< -o $@

LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld 
SRC=main.c second.c 
OBJS=$(patsubst %.c,%.o,$(SRC))

firmware.elf: $(OBJS)
	$(LD) -o $@ $^

all: firmware.elf

clean:
	rm -f main.i main.s main.o second.i second.s second.o hello.txt firmware.elf

.PHONY: clean all

#main.i: main.c 
#	$(CPP) main.c > main.i

#main.s: main.i
#	$(CC) -S main.i

#main.o: main.s 
#	$(AS) main.s -o main.o

#second.i: second.c 
#	$(CPP) second.c > second.i

#second.s: second.i
#	$(CC) -S second.i

#second.o: second.s 
#	$(AS) second.s -o second.o 
