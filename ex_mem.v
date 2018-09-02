module EX_MEM(
  input clock,
  input [31:0] readALU,
  input [31:0] PC,
  input [31:0] readWriteData,
  input [1:0] readWB,
  input [6:0] readBranchAddress,
  input [4:0] readRD,
  input [2:0] readMem,
  input readZF,
  input readBNE,

  output reg [31:0] aluResult,
  output reg [31:0] writeData,
  output reg [6:0] branchAddress,
  output reg [4:0] rd,
  output reg [1:0] wb,
  output reg ZF,
  output reg memRead,
  output reg memWrite,
  output reg branch,
  output reg BNE
);

  initial begin
    aluResult = 32'b0;
    writeData = 32'b0;
    branchAddress = 7'b0;
    rd = 5'b0;
    wb = 2'b0;
    memRead = 0;
    memWrite = 0;
    branch = 0;
    ZF = 0;
    BNE = 0;
  end

  always @(posedge clock) begin
    writeData <= readWriteData;
    aluResult <= readALU;
    branchAddress <= readBranchAddress;
    rd <= readRD;
    wb <= readWB;
    memWrite <= readMem[0];
    memRead <= readMem[1];
    branch <= readMem[2];
    ZF <= readZF;
    BNE <= readBNE;
  end


endmodule
