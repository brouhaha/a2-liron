all: liron-if.bin liron-if.lst check

%.lst %.p: %.asm
	asl $< -o $@ -L

liron-if.p liron-if.lst: liron-if.asm
	asl liron-if.asm -o liron-if.p -L

liron-if.bin: liron-if.p
	p2bin -r '$$c000-$$cfff' liron-if.p

define myvar
  # line 1\nline 2\nline 3\n#etc\n
  endef

check: liron-if.bin
	echo "42c1ae66c6bec932669239599eb8989a5364752d56fa5c8997bb23d8dfc0b657 liron-if.bin" | sha256sum -c -

clean:
	rm liron-if.bin *.p *.lst
