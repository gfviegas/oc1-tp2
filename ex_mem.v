module exMem(
  input wire clock,

  // Inputs
  // MEM

  // WB
  input wire [1:0] wbControlInput,

  input wire [31:0] readALU,
  input wire [31:0] PC,
  input wire [31:0] readWriteData,
  input wire [1:0] readWB,
  input wire [6:0] readBranchAddress,
  input wire [4:0] readRD,
  input wire [2:0] readMem,
  input wire readZF,
  input wire readBNE,

  // Outputs
  // MEM

  // WB
  output reg [1:0] wbControlExMem,

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
    // MEM

    // WB
    wbControlExMem <= 0;

    // EX_MEM
    aluResult <= 32'b0;
    writeData <= 32'b0;
    branchAddress <= 7'b0;
    rd <= 5'b0;
    wb <= 2'b0;
    memRead <= 0;
    memWrite <= 0;
    branch <= 0;
    ZF <= 0;
    BNE <= 0;
  end

  always @(posedge clock) begin
    // MEM

    // WB
    wbControlExMem <= wbControlInput;

    // EX_MEM
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
