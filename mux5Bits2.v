// Multiplexador de 2 entradas simples.

// MUX DE ENTRADAS DE 5 BITS
module mux5Bits2 (
  input wire [4:0] entrada1,
  input wire [4:0] entrada2,
  input wire seletor,
  output reg [4:0] saida
);

  // Se seletor == 1, entao o output será a entrada1. Caso contrário, a entrada2.
  always @(*) saida <= (seletor) ? entrada1 : entrada2;
endmodule
