C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

all: os-image.bin

run: all
	qemu-system-i386 -fda os-image.bin

os-image.bin: boot/boot_sect.bin kernel.bin
	cat boot/boot_sect.bin kernel.bin > os-image.bin

kernel.bin: kernel/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c ${HEADERS}
	i386-elf-gcc -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm -f bin -I './boot/' $< -o $@

clean:
	rm -f *.bin *.dis *.o
	rm -f boot/*.bin kernel/*.o drivers/*.o
