`include "mux_4-1.v"

// Unidade Logica Aritmetica -> Somador, Subtrador, AND e OR
module ula (
  input wire entrada1,
  input wire entrada2,
  input wire [0:1] seletor,
  output wire saida
);

  reg opSoma;
  reg opSubtracao;
  reg opAnd;
  reg opOr;

  // Multiplexador da ULA:
  // -> 1º = Soma
  // -> 2º = Subtração
  // -> 3º = And
  // -> 4º = Or
  mux4_1 mux(
    opSoma,
    opSubtracao,
    opAnd,
    opOr,
    seletor,
    saida
  );

  initial begin
    opSoma = entrada1 + entrada2;
    opSubtracao = entrada1 - entrada2;
    opAnd = entrada1 && entrada2;
    opOr = entrada1 || entrada2;
  end
endmodule
