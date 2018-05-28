module instructionControl (
  input wire [5:0] opCode,
  output reg regDest,
  output reg branch,
  output reg memRead,
  output reg memToReg,
  output reg [1:0] aluOp,
  output reg memWrite,
  output reg aluSrc,
  output reg regWrite
);

  reg [5:0] tipoR = 6'b000000;
  reg [5:0] lw = 6'b110001;
  reg [5:0] sw = 6'b110101;
  reg [5:0] beq = 6'b001000;

  always @(opCode) begin
    // $display("opcode has changed. InstructionControl.v");
    case (opCode)
      tipoR:
        begin
          regDest = 1;
          branch = 0;
          memRead = 0;
          memToReg = 0;
          aluOp = 2'b10;
          memWrite = 0;
          aluSrc = 0;
          regWrite = 1;
        end
      lw:
        begin
          regDest = 0;
          branch = 0;
          memRead = 1;
          memToReg = 1;
          aluOp = 2'b00;
          memWrite = 0;
          aluSrc = 1;
          regWrite = 1;
        end
      sw:
        begin
          regDest = 0; // X/Not Care
          branch = 0;
          memRead = 0;
          memToReg = 0; // X/Not Care
          aluOp = 2'b00;
          memWrite = 1;
          aluSrc = 1;
          regWrite = 0;
        end
      beq:
        begin
          regDest = 0; // X/Not Care
          branch = 1;
          memRead = 0;
          memToReg = 0;
          aluOp = 2'b01;
          memWrite = 0;
          aluSrc = 0;
          regWrite = 0;
        end
    endcase
  end
endmodule
