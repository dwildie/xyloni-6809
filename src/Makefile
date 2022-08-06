.DEFAULT_GOAL := all

AS		:= asm6809
FPGA_ROM_FILES	:= ../../fpga-z80-board/rom_files/

%.srec: %.asm
	$(AS)  -S -o $@ -l $(@:.srec=.lst) $<

%.mif: %.srec
	srec_cat $< -crop 0xF000 0x10000 -offset -0xF000 -o $@ -Memory_Initialization_File 8 -Output_Block_Size 1 -disable Execution_Start_Address 

%.inithex: %.srec
	srec_cat $< -crop 0xF800 0x10000 -fill 0x00 0xF800 0x10000 -offset -0xF800 -Output -VMem 1 -Output_Block_Size 1 -disable Header | sed -e 's/^.* //' > $@
	
all: test.mif test.inithex

clean:
	-rm -f *.lst *.bin *.srec *.hex *.mif *.inithex
