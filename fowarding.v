module fowarding(
  input wire clock,

  // INPUTS
  input wire [4:0] rs,
  input wire [4:0] rt,

  // EX/MEM
  input wire [4:0] writeRegister, // registerRD
  input wire regWrite,

  // MEM/WB
  input wire [4:0] writeRegisterMemWb, // registerRD
  input wire regWriteMemWb,

  // OUTPUTS
  output reg [1:0] fowardA,
  output reg [1:0] fowardB
);

  initial begin
    fowardA <= 0;
    fowardB <= 0;
  end

  always @(posedge clock) begin

    // Foward EX
    if (regWrite && (writeRegister != 0) && (writeRegister == rs))
      fowardA <= 2'b10;
    else if (regWriteMemWb && (writeRegisterMemWb != 0) && !(regWrite && (writeRegister != 0)) && (writeRegister != rs) && (writeRegisterMemWb == rs))
      fowardA <= 2'b01;
    else
      fowardA <= 2'b00;


    // Foward MEM
    if (regWrite && (writeRegister != 0) && (writeRegister == rt))
      fowardB <= 2'b10;
    else if (regWriteMemWb && (writeRegisterMemWb != 0) && !(regWrite && (writeRegister != 0)) && (writeRegister != rt) && (writeRegisterMemWb == rt))
      fowardB <= 2'b01;
    else
      fowardB <= 2'b00;
  end

endmodule
