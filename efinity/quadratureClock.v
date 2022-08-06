module quadratureClock
(
  input clock,
  output reg E,
  output reg Q
);

  reg [1:0] clk_phase = 2'b00;

  initial begin
    E <= 1;
    Q <= 0;
  end
  
  always @(negedge clock)
  begin
      case (clk_phase)
          2'b00: begin
              E   <= 0;
            end
          2'b01: begin
              Q   <= 1;
            end
          2'b10: begin
              E   <= 1;
            end
          2'b11: begin
              Q   <= 0;
            end
      endcase

      clk_phase <= clk_phase + 2'b01;

  end
endmodule