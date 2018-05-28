module registers (
  input wire regWrite, // RegWrite que vem do Control
  input wire [4:0] register1, // Primeiro argumento de leitura da instrucao
  input wire [4:0] register2, // Segundo argumento de leitura da instrucao
  input wire [4:0] writeRegister, // Registrador de escrita, se tiver, da instrucao
  input wire [31:0] writeData, // Dado a ser escrito na memoria referenciada ao registrador de escrita
  output wire [31:0] readData1, // Dado armazenado no registrador register1
  output wire [31:0] readData2 // Dado armazenado no registrador register2
);

endmodule
