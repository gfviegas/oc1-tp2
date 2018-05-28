module instructionMemory (
  input wire clock,
  input wire [31:0] readAddress,
  output wire [31:0] instruction
);

  reg [31:0] memory [0:5]; // 6 instrucoes de 32 bits

  initial begin
    $readmemh("instructions.bin", memory);
  end

  assign instruction = memory[readAddress[9:2]];
endmodule
