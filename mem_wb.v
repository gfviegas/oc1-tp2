module MEM_WB(
  input clock,
  input [31:0] readMemoryWord,
  input [31:0] readALU,
  input [4:0] readRD,
  input [1:0] WB,

  output reg [31:0] memoryWord,
  output reg [31:0] aluResult,
  output reg [4:0] RD,
  output reg regWrite,
  output reg memToReg
);

  initial begin
    memoryWord = 32'b0;
    aluResult = 32'b0;
    RD = 5'b0;
    regWrite = 0;
    memToReg = 0;
  end

  always @(posedge clock) begin
    memoryWord = readMemoryWord;
    aluResult = readALU;
    RD = readRD;
    regWrite = WB[1];
    memToReg = WB[0];
  end


endmodule
