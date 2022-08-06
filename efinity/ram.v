module ram
(
    input        clock,
    input [11:0] address,
    input        select,
    input        rw,
    input [7:0]  dataIn,
    output [7:0] dataOut
);

wire [7:0] dataOut0;
wire [7:0] dataOut1;
wire [7:0] dataOut2;
wire [7:0] dataOut3;
wire [7:0] dataOut4;
wire [7:0] dataOut5;
wire [7:0] dataOut6;
wire [7:0] dataOut7;

ram512 ramBlock0 (
    .clock(clock),
    .address(address[8:0]),
    .dataOut(dataOut0),
    .dataIn(dataIn),
    .select(select && address[11:9] == 3'b000),
    .rw(rw)
);

ram512 ramBlock1 (
    .clock(clock), 
    .address(address[8:0]),
    .dataOut(dataOut1),
    .dataIn(dataIn),
    .select(select && address[11:9] == 3'b001),
    .rw(rw)
);

ram512 ramBlock2 (
    .clock(clock),
    .address(address[8:0]),
    .dataOut(dataOut2),
    .dataIn(dataIn),
    .select(select && address[11:9] == 3'b010),
    .rw(rw)
);

ram512 ramBlock3 (
    .clock(clock), 
    .address(address[8:0]),
    .dataOut(dataOut3),
    .dataIn(dataIn),
    .select(select && address[11:9] == 3'b011),
    .rw(rw)
);

ram512 ramBlock4 (
    .clock(clock),
    .address(address[8:0]),
    .dataOut(dataOut4),
    .dataIn(dataIn),
    .select(select && address[11:9] == 3'b100),
    .rw(rw)
);

ram512 ramBlock5 (
    .clock(clock), 
    .address(address[8:0]),
    .dataOut(dataOut5),
    .dataIn(dataIn),
    .select(select && address[11:9] == 3'b101),
    .rw(rw)
);

ram512 ramBlock6 (
    .clock(clock),
    .address(address[8:0]),
    .dataOut(dataOut6),
    .dataIn(dataIn),
    .select(select && address[11:9] == 3'b110),
    .rw(rw)
);

ram512 ramBlock7 (
    .clock(clock), 
    .address(address[8:0]),
    .dataOut(dataOut7),
    .dataIn(dataIn),
    .select(select && address[11:9] == 3'b111),
    .rw(rw)
);


assign dataOut = address[11:9] == 3'b000 ? dataOut0 :
                 address[11:9] == 3'b001 ? dataOut1 :
                 address[11:9] == 3'b010 ? dataOut2 :
                 address[11:9] == 3'b011 ? dataOut3 :
                 address[11:9] == 3'b100 ? dataOut4 :
                 address[11:9] == 3'b101 ? dataOut5 :
                 address[11:9] == 3'b110 ? dataOut6 :
                 address[11:9] == 3'b111 ? dataOut7 :
                                           8'hFF;

endmodule
