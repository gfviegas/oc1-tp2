module instructionControl (
  input wire [4:0] opCode,
  output reg regDest,
  output reg branch,
  output reg memRead,
  output reg memToReg,
  output reg [1:0] aluOp,
  output reg memWrite,
  output reg aluSrc,
  output reg regWrite
);

  always @ (opCode) begin
    if (opCode == 0) // Tipo R!
      begin
        regDest = 1;
        branch = 0;
        memRead = 0;
        memToReg = 0;
        aluOp = 2'b01;
        memWrite = 0;
        aluSrc = 0;
        regWrite = 1;
      end
    else
      begin
        // Deve se tratar tipo I, LW, SW, BEQ...
      end
  end
endmodule
