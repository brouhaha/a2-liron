all: liron.bin liron.lst liron-check liron-if.bin liron-if.lst liron-if-check

%.lst %.p: %.asm
	asl $< -o $@ -L

liron.bin: liron.p
	p2bin -r '$$e000-$$ffff' liron.p

liron-if.bin: liron-if.p
	p2bin -r '$$c000-$$cfff' liron-if.p

liron-check: liron.bin
	echo "9f9f9160938f0b69c6f532f9acf194e3b48de8b195b6b47faad8423d6c1e3cce liron.bin" | sha256sum -c -

liron-if-check: liron-if.bin
	echo "42c1ae66c6bec932669239599eb8989a5364752d56fa5c8997bb23d8dfc0b657 liron-if.bin" | sha256sum -c -

clean:
	rm liron-if.bin *.p *.lst
