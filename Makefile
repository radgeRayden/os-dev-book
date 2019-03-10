build:
	nasm -fbin boot_sect.asm -o boot_sect.bin
run:
	qemu-system-x86_64 -display sdl -drive file=boot_sect.bin,format=raw,media=disk,index=0,if=floppy -monitor stdio
