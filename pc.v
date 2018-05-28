module pc (
  input wire [31:0] nextAddress,
  input clock,
  output reg [31:0] readAddress
);
  initial begin
    readAddress <= 0;
  end

  always @(posedge clock) begin
    readAddress <= nextAddress;
  end
endmodule
