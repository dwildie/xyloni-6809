module addressDecoder
(
  input [15:0] address,           // CPU address bus (logical address)
  input        E,                 // E clock
  input        readNotWrite,      // Read not write
  
  output       romSelect,         // FPGA ROM
  output       ramSelect,         // Onboard RAM
  output       usbSelect          // ACIA for onboard USB
);
/*
  System memory map
  
  +---------------+
  | 80000 - FFFFF | S100 RAM - Available
  +---------------+
  | 10000 - 7FFFF | Onboard RAM - Available
  +---------------+
  | 0FFF0 - 0FFFF | Vectors (read), DAT tables (write)
  +---------------+
  | 0F000 - 0FFEF | 4K FPGA ROM
  +---------------+
  | 0EC00 - 0EFFF | Onboard RAM - 1K Disk buffer
  +---------------+
  | 0E400 - 0EBFF | RAM - Available
  +---------------+
  | 0E300 - 0E3FF | Reserved
  +---------------+
  | 0E200 - 0E2FF | FPGA & board IO
  +---------------+
  | 0E100 - 0E1FF | S100 IO
  +---------------+
  | 0E000 - 0E0FF | SWTP IO
  +---------------+
  | 00000 - 0DFFF | Onboard RAM - Mapped
  +---------------+
*/


  // ROM = address 0xF800 - 0xFFFF
  assign romSelect = E && readNotWrite && address[15:11] == 5'b11111;

  // USB ACIA = 0x00EFF8 - Ox0EFF9
  assign usbSelect = E && (address[15:0] == 16'hE010 || address[15:0] == 16'hE011);

  // Onboard RAM = 0xD000 - 0xDFFF
  assign ramSelect = E && address[15:12] == 4'hD;
endmodule

