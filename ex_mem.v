module exMem(
  input wire clock,

  // Inputs
  // MEM
  input wire [1:0] memControlInput,

  // WB
  input wire [1:0] wbControlInput,

  // EX_MEM
  input wire [31:0] aluResultInput,
  input wire [31:0] aluZeroInput,
  input wire [31:0] pcInput,
  input wire [31:0] registerDataInput,
  input wire [31:0] writeRegisterInput,


  // Outputs
  // MEM
  output reg branch,
  output reg memRead,
  output reg memWrite,

  // WB
  output reg [1:0] wbControlExMem,

  // EX_MEM
  output reg [31:0] aluResult,
  output reg [31:0] aluZero,
  output reg [31:0] pc,
  output reg [31:0] registerData,
  output reg [31:0] writeRegister
);

  initial begin
    // MEM
    branch <= 0;
    memRead <= 0;
    memWrite <= 0;

    // WB
    wbControlExMem <= 0;

    // EX_MEM
    aluResult <= 0;
    aluZero <= 0;
    pc <= 0;
    registerData <= 0;
    writeRegister <= 0;
  end

  always @(posedge clock) begin
    // MEM
    branch <= memControlInput[2];
    memRead <= memControlInput[1];
    memWrite <= memControlInput[0];

    // WB
    wbControlExMem <= wbControlInput;

    // EX_MEM
    aluResult <= aluResultInput;
    aluZero <= aluZeroInput;
    pc <= pcInput;
    registerData <= registerDataInput;
    writeRegister <= writeRegisterInput;
  end


endmodule
