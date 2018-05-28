// Multiplexador de 4 entradas simples.
module mux4_1 (
  input wire entrada1,
  input wire entrada2,
  input wire entrada3,
  input wire entrada4,
  input wire [1:0] seletor,
  output wire saida
);

  // Se seletor[1] é 1:
  // -> Se seletor[0] é 1:
  //    -> Saida = entrada4
  // -> Se seletor[0] é 0:
  //    -> Saida = entrada3

  // Se seletor[1] é 0:
  // -> Se seletor[0] é 1:
  //    -> Saida = entrada2
  // -> Se seletor[0] é 0:
  //    -> Saida = entrada1
  assign saida = (seletor[1]) ? ((seletor[0]) ? entrada4 : entrada3) : ((seletor[0]) ? entrada2 : entrada1);
endmodule
