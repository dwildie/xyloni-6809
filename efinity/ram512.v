module ram512
(
    input        clock,
    input [8:0]  address,
    input        select,
    input        rw,
    input [7:0]  dataIn,
    output [7:0] dataOut
);

EFX_RAM_5K # (
    .READ_WIDTH(8),        // 512 x 8
    .WRITE_WIDTH(8),       // 512 x 8
    .OUTPUT_REG(1'b0),     // 1 add pipe-line read register
    .RCLK_POLARITY(1'b1),  // 0 falling edge, 1 rising edge
    .RE_POLARITY(1'b1),    // 0 active low, 1 active high
    .WCLK_POLARITY(1'b1),  // 0 falling edge, 1 rising edge
    .WE_POLARITY(1'b1),    // 0 active low, 1 active high
    .WCLKE_POLARITY(1'b1), // 0 active low, 1 active high
    .WRITE_MODE("READ_FIRST"),
    .INIT_0(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_8(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_9(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000)
) ramBlock (
    .RDATA(dataOut),     // Read data output
    .RADDR(address),     // Read address input
    .RCLK(select),       // Read clock input
    .RE(rw),             // Read-enable input
    .WDATA(dataIn),      // Write data input
    .WADDR(address),     // Write address input
    .WCLK(select),       // Write clock input
    .WE(!rw),            // Write-enable input
    .WCLKE(1'b1)         // Write clock-enable input
);
endmodule