build_artifacts := kernel/build/kernel-x86_64 boot/grub/grub.cfg

.PHONY: all clean test

all: clean disk.iso

test: clean disk.iso
	@qemu-system-x86_64 disk.iso

disk.iso: build
	@grub-mkrescue -o disk.iso build/ 2> /dev/null

build: $(build_artifacts)
	@mkdir build
	@cp -r boot build/boot
	@cp kernel/build/kernel-x86_64 build/boot/kernel

kernel/build/kernel-x86_64:
	@$(MAKE) -C kernel

clean:
	-@rm disk.iso
	-@rm -r build/
	-@$(MAKE) -C kernel clean
