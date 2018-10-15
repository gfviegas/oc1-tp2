module ifId(
  input wire clock,
  input hzdWrite,
  input [31:0] instruction,
  input [31:0] pc,

  output reg [0:31] outPc,
  output reg [0:31] outInstruction
);

  initial begin
    outPc <= 0;
    outInstruction <= 0;
  end

  always @(posedge clock && hzdWrite) begin
    outInstruction <= instruction;
    outPc <= pc;
  end
endmodule
