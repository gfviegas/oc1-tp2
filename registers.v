module registers (
  input wire regWrite, // RegWrite que vem do Control
  input wire [4:0] register1, // Primeiro argumento de leitura da instrucao
  input wire [4:0] register2, // Segundo argumento de leitura da instrucao
  input wire [4:0] writeRegister, // Registrador de escrita, se tiver, da instrucao
  input wire [31:0] writeData, // Dado a ser escrito na memoria referenciada ao registrador de escrita
  output wire [31:0] readData1, // Dado armazenado no registrador register1
  output wire [31:0] readData2 // Dado armazenado no registrador register2
);

  reg [31:0] registradores [31:0];

  initial begin
    registradores[0] <= 0;
    registradores[1] <= 0;
    registradores[2] <= 0;
    registradores[3] <= 0;
    registradores[4] <= 0;
    registradores[5] <= 0;
    registradores[6] <= 0;
    registradores[7] <= 0;
    registradores[8] <= 0;
    registradores[9] <= 0;
    registradores[10] <= 0;
    registradores[11] <= 0;
    registradores[12] <= 0;
    registradores[13] <= 0;
    registradores[14] <= 0;
    registradores[15] <= 0;
    registradores[16] <= 0;
    registradores[17] <= 0;
    registradores[18] <= 0;
    registradores[19] <= 0;
    registradores[20] <= 0;
    registradores[21] <= 0;
    registradores[22] <= 0;
    registradores[23] <= 0;
    registradores[24] <= 0;
    registradores[25] <= 0;
    registradores[26] <= 0;
    registradores[27] <= 0;
    registradores[28] <= 0;
    registradores[29] <= 0;
    registradores[30] <= 0;
    registradores[31] <= 0;
  end

  always @(posedge regWrite) begin
    $display("regWrite has changed. registers.v -> %b = %b", regWrite, writeData);
    registradores[writeRegister] = writeData;
  end

  assign readData1 = registradores[register1];
  assign readData2 = registradores[register2];
endmodule
