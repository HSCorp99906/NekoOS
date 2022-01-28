all:	
	@ # Prepare the image.
	nasm -fbin src/x86/boot/bootloader.S -o bin/bootloader.bin
	# nasm -felf32 src/x86/kernel/kernel.S -o objres/kernel.o
	# ld -melf_i386 -Tlink.ld objres/*.o --oformat binary -o bin/kernel.bin
	cat bin/bootloader.bin > bin/NekoOS.bin
	sudo dd if=/dev/zero of=NekoOS.img bs=1024 count=1440
	@ # Put the OS stuff in the image.
	sudo dd if=bin/NekoOS.bin of=NekoOS.img

burnusb:
	sudo dd if=NekoOS.img of=/dev/sdb

runusb:
	sudo qemu-system-x86_64 -hda /dev/sdb -monitor stdio

run:
	sudo qemu-system-x86_64 -fda NekoOS.img -monitor stdio
