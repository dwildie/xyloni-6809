/* ------------------------------------------------------------------
 * M6809 Test system
 *
 * Damian Wildie
 * ------------------------------------------------------------------*/
module M6809
(
  input  QUAD_CLOCK,
  input  RESET,
  output e,
  output q,
  input  RX,
  output TX,
  output b
);

wire        ACIA_BAUD;
wire [7:0]  M6809_DATA_IN;
wire [7:0]  M6809_DATA_OUT;
wire [15:0] M6809_ADDR;
wire        M6809_BA;
wire        M6809_BS;
wire        M6809_RW;
wire        ROM_SELECT;
wire        RAM_SELECT;
wire        USB_SELECT;
wire [7:0]  ROM_DATA_OUT;
wire [7:0]  RAM_DATA_OUT;
wire [7:0]  USB_DATA_OUT;

quadratureClock inst_quadClock
(
    .clock(QUAD_CLOCK),
    .E(e),
    .Q(q)    
);

baudCounter inst_baudCounter
(
    .clk(QUAD_CLOCK),
    .baudClk(ACIA_BAUD)
);

assign b = ACIA_BAUD;

cpu09 inst_cpu09
(
    .clk(e),
    .rst(!RESET),
    .irq(1'b0),
    .firq(1'b0),
    .nmi(1'b0),
    .halt(1'b0),
    .hold(1'b0),
    .data_in(M6809_DATA_IN),
    .data_out(M6809_DATA_OUT),
    .addr(M6809_ADDR),
    .ba(M6809_BA),
    .bs(M6809_BS),
    .rw(M6809_RW)
);

addressDecoder inst_addrDecoder
(
    .address(M6809_ADDR),
    .readNotWrite(M6809_RW),
    .E(e),
    .romSelect(ROM_SELECT),
    .ramSelect(RAM_SELECT),
    .usbSelect(USB_SELECT)
);

dataBus inst_dataBus
(
    .romData(ROM_DATA_OUT),
    .ramData(RAM_DATA_OUT),
    .usbData(USB_DATA_OUT),
    .romSelect(ROM_SELECT),
    .ramSelect(RAM_SELECT),
    .usbSelect(USB_SELECT),
    .dataOut(M6809_DATA_IN)
);

acia6850 inst_acia6850
(
    .Clk(e),
    .RxClock(ACIA_BAUD),
    .TxClock(ACIA_BAUD),
    .RxData(RX),
    .Reset_H(!RESET),
    .CS_H(USB_SELECT),
    .Write_L(M6809_RW),
    .RS(M6809_ADDR[0]),
    .DataIn(M6809_DATA_OUT),
    .TxData(TX),
    .DataOut(USB_DATA_OUT),
    .CTS_L(1'b0),
    .DCD_L(1'b0)
);

rom inst_rom
(
    .clock(e),
    .address(M6809_ADDR[10:0]),
    .select(ROM_SELECT),
    .data(ROM_DATA_OUT)
);

ram inst_ram
(
    .clock(e),
    .address(M6809_ADDR[11:0]),
    .select(RAM_SELECT),
    .rw(M6809_RW),
    .dataIn(M6809_DATA_OUT),
    .dataOut(RAM_DATA_OUT)
);

endmodule
