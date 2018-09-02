module ifId(
  input wire clock,
  output reg [31:0] pc,
  output reg [31:0] instruction,
  output reg [0:31] outPc,
  output reg [0:31] outInstruction
);

  initial begin
    pc <= 0;
    instruction <= 0;
  end

  always @(posedge clock) begin
    outPc <= pc;
    outInstruction <= instruction;
  end

endmodule
