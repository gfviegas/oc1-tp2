module registers (
  input wire regWrite, // RegWrite que vem do Control
  input wire [4:0] register1, // Primeiro argumento de leitura da instrucao
  input wire [4:0] register2, // Segundo argumento de leitura da instrucao
  input wire [4:0] writeRegister, // Registrador de escrita, se tiver, da instrucao
  input wire [31:0] writeData, // Dado a ser escrito na memoria referenciada ao registrador de escrita
  output reg [31:0] readData1, // Dado armazenado no registrador register1
  output reg [31:0] readData2 // Dado armazenado no registrador register2
);

  reg [31:0] registradores [31:0];

  initial begin
    registradores[0] = 32'b0; // ZR
    registradores[1] = 32'b01; //AT
    registradores[2] = 32'b10; // V0
    registradores[3] = 32'b11; //V1
    registradores[4] = 32'b100; // A0
    registradores[5] = 32'b101; //A1
    registradores[6] = 32'b110; // A2
    registradores[7] = 32'b111; //A3
    registradores[8] = 32'b1000; // T0
    registradores[9] = 32'b1001; //T1
    registradores[10] = 32'b1010; //T2
    registradores[11] = 32'b1011; //T3
    registradores[12] = 32'b1100; //T4
    registradores[13] = 32'b1101; //T5
    registradores[14] = 32'b1110; //T6
    registradores[15] = 32'b1111; //T7
    registradores[16] = 32'b10000; //S0
    registradores[17] = 32'b10001; //S1
    registradores[18] = 32'b10010; //S2
    registradores[19] = 32'b10011; //S3
    registradores[20] = 32'b10100; //S4
    registradores[21] = 32'b10101; //S5
    registradores[22] = 32'b10110; //S6
    registradores[23] = 32'b10111; //S7
    registradores[24] = 32'b11000; //T8
    registradores[25] = 32'b11001; //T9
    registradores[26] = 32'b11010; //K0
    registradores[27] = 32'b11011; //K1
    registradores[28] = 32'b11100; //GP
    registradores[29] = 32'b11101; //SP
    registradores[30] = 32'b11110; //FP
    registradores[31] = 32'b11111; //RA
  end

  always @(register1, register2) begin
    $display("regWrite has changed. registers.v -> %b = %b", regWrite, writeData);
    readData1 = registradores[register1];
    readData2 = registradores[register2];
  end

endmodule
