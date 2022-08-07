/* ------------------------------------------------------------------
 * Address decoder
 *
 * Copyright (C) 2022 Damian Wildie
 * ------------------------------------------------------------------*/
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
  | 0F800 - 0FFFF | 2K FPGA ROM
  +---------------+
  | 0E012 - 0F7FF | Unused
  +---------------+
  | 0E010 - 0E011 | M6850 ACIA
  +---------------+
  | 0E000 - 0E00F | Unused
  +---------------+
  | 0D000 - 0DFFF | 4K FPGA RAM
  +---------------+
  | 00000 - 0CFFF | Unused
  +---------------+
*/


  // ROM = address 0xF800 - 0xFFFF
  assign romSelect = E && readNotWrite && address[15:11] == 5'b11111;

  // USB ACIA = 0x00EFF8 - Ox0EFF9
  assign usbSelect = E && (address[15:0] == 16'hE010 || address[15:0] == 16'hE011);

  // Onboard RAM = 0xD000 - 0xDFFF
  assign ramSelect = E && address[15:12] == 4'hD;
endmodule

