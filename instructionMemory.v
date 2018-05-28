module instructionMemory (
  input wire clock,
  input wire [31:0] readAddress,
  output wire [31:0] instruction
);

  parameter instrucoes = "instrucoes.txt";
  reg [31:0] memory [0:127];

  initial begin
    $readmemh(instrucoes, memory, 0, 127);
  end

  assign instruction = memory[readAddress[8:2]][31:0];
endmodule
