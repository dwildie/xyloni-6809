/* ------------------------------------------------------------------
 * Data bus
 *
 * Copyright (C) 2022 Damian Wildie
 * ------------------------------------------------------------------*/
module dataBus
(
  input [7:0]  romData,
  input [7:0]  ramData,
  input [7:0]  usbData,
  
  input        romSelect,     // FPGA ROM select
  input        ramSelect,     // Onboard RAM select
  input        usbSelect,     // USB ACIA
  
  output wire [7:0] dataOut
);

  reg [7:0] source;
  
  always @* begin
    if (romSelect)                      source = romData;
    else if (ramSelect)                 source = ramData;
    else if (usbSelect)                 source = usbData;
    else                                source = 8'hFF;  
  end
  
  assign dataOut = source;
  
endmodule