module registers (
  input wire [0:4] register1, // Primeiro argumento de leitura da instrucao
  input wire [0:4] register2, // Segundo argumento de leitura da instrucao
  input wire [0:4] writeRegister, // Registrador de escrita, se tiver, da instrucao
  input wire writeData, // Dado a ser escrito na memoria referenciada ao registrador de escrita
  output wire readData1, // Dado armazenado no registrador register1
  output wire readData2 // Dado armazenado no registrador register2
);

endmodule
