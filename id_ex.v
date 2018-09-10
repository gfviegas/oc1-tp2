module idEx(
    input wire clock,

    // Inputs
    // EX
    input wire regDestInput,
    input wire [1:0] aluOpInput,
    input wire aluSrcInput,

    // MEM
    input wire branchInput,
    input wire memReadInput,
    input wire memWriteInput,

    // WB
    input wire memToRegInput,
    input wire regWriteInput,

    // ID_EX
    input wire [31:0] readData1Input,
    input wire [31:0] readData2Input,
    input wire [31:0] signExtendWireInput,
    input wire [4:0] rdInput,
    input wire [4:0] rtInput,
    input wire [31:0] ifIdInput,

    // Outputs
    // EX
    output reg regDest,
    output reg [1:0] aluOp,
    output reg aluSrc,

    // MEM
    output reg branch,
    output reg memRead,
    output reg memWrite,

    // WB
    output reg memToReg,
    output reg regWrite,

    // ID_EX
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    output reg [31:0] signExtendWire,
    output reg [4:0] rd,
    output reg [4:0] rt,
    output reg [31:0] ifId
);

    initial begin
      // EX
      regDest <= 0;
      aluOp <= 0;
      aluSrc <= 0;

      // Memory Access
      branch <= 0;
      memRead <= 0;
      memWrite <= 0;

      // WB
      regWrite <= 0;
      memToReg <= 0;

      // ID_EX
      readData1 <= 0;
      readData2 <= 0;
      signExtendWire <= 0;
      rd <= 0;
      rt <= 0;
      ifId <= 0;
    end

    always @(posedge clock) begin
      // EX
      regDest <= regDestInput;
      aluOp <= aluOpInput;
      aluSrc <= aluSrcInput;

      // Memory Access
      branch <= branchInput;
      memRead <= memReadInput;
      memWrite <= memWriteInput;

      // WB
      regWrite <= regWriteInput;
      memToReg <= memToRegInput;

      // ID_EX
      readData1 <= readData1Input;
      readData2 <= readData2Input;
      signExtendWire <= signExtendWireInput;
      rd <= rdInput;
      rt <= rtInput;
      ifId <= ifIdInput;
    end

endmodule
