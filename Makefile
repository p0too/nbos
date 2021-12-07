run: os-image
	qemu-system-i386 os-image

kernel.bin: kernel_entry.o kernel.o
	ld -melf_i386 -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary

kernel_entry.o: kernel_entry.asm
	nasm kernel_entry.asm -f elf -o kernel_entry.o

kernel.o: kernel.c
	gcc -m32 -ffreestanding -fno-pie -c kernel.c -o kernel.o

boot13_load_kernel.bin: boot13_load_kernel.asm
	nasm -f bin boot13_load_kernel.asm -o boot13_load_kernel.bin

os-image: boot13_load_kernel.bin kernel.bin
	cat boot13_load_kernel.bin kernel.bin > os-image

clean:
	rm os-image *.o *.bin
