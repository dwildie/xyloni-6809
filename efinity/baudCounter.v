module baudCounter
(
    input clk,
    output baudClk
);

  reg [3:0] baud;

  initial begin
    baud <= 0;
  end
  
  always @(posedge clk) begin
    baud <= baud + 1;
  end
  
  assign baudClk = baud[3];
endmodule