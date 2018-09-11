module memWb(
  input clock,

  // Inputs
  // WB
  input wire [1:0] wbControlInput,

  // MEM_WB
  input wire [31:0] readDataMemoryInput,
  input wire [31:0] aluResultInput,
  input wire [4:0] writeRegisterInput,


  // Outputs
  // WB
  output reg regWrite,
  output reg memToReg,

  // MEM_WB
  output reg [31:0] readDataMemory,
  output reg [31:0] aluResult,
  output reg [4:0] writeRegister
);

  initial begin
    // WB
    regWrite <= 0;
    memToReg <= 0;

    // MEM_WB
    readDataMemory <= 0;
    aluResult <= 0;
    writeRegister <= 0;
  end

  always @(posedge clock) begin
    // WB
    regWrite <= wbControlInput[1];
    memToReg <= wbControlInput[0];

    // MEM_WB
    readDataMemory <= readDataMemoryInput;
    aluResult <= aluResultInput;
    writeRegister <= writeRegisterInput;
  end

endmodule
