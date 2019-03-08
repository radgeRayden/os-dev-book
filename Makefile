build:
	nasm -fbin boot_sect.asm -o boot_sect.bin
run:
	qemu-system-x86_64 -display sdl boot_sect.bin
