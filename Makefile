hello.txt:
	echo "hello world" > hello.txt

CPP=$(PICO_TOOLCHAIN_PATH)/opt/homebrew/bin/arm-none-eabi-cpp

main.i: main.c 
	$(CPP) main.c > main.i

clean:
	rm -f main.i second.i hello.txt

.PHONY: clean

CC=$(PICO_TOOLCHAIN_PATH)/opt/homebrew/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/opt/homebrew/bin/arm-none-eabi-AS

main.s: main.i
	$(CC) -S main.i

#main.o: main.s 
#	$(AS) main.s -o main.o

second.i: second.c 
	$(CPP) second.c > second.i

second.s: second.i
	$(CC) -S second.i

#second.o: second.s 
#	$(AS) second.s -o second.o 

%.o : %.s 
	$(AS) $< -o $@
