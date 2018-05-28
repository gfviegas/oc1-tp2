// Multiplexador de 2 entradas simples.
module mux2_1 (
  input wire entrada1,
  input wire entrada2,
  input wire seletor,
  output wire saida
);

  // Se seletor == 1, entao o output será a entrada1. Caso contrário, a entrada2.
  assign saida = (seletor) ? entrada1 : entrada2;
endmodule
