module rom
(
    input        clock,
    input [10:0] address,
    input        select,
    output [7:0] data
);

wire [7:0] romData;

single_port_rom #(
    .DATA_WIDTH(8),
    .ADDR_WIDTH(11),
    .OUTPUT_REG("FALSE"),
    .RAM_INIT_FILE("../src/test.inithex")
) inst_singlePortRom (
    .addr(address),
    .data(romData),
    .clk(clock)
);

assign data = select ? romData : 8'hFF;

endmodule
