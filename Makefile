run: boot.bin
	qemu-system-x86_64 -hda boot.bin

boot.bin:
	nasm -f bin boot/boot.asm -I boot/ -o boot.bin
	dd if=./message.txt >> ./boot.bin
	dd if=/dev/zero bs=512 count=1 >> ./boot.bin

clean:
	rm -rf */*.bin