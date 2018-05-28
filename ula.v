`include "mux_6-1.v"

// Unidade Logica Aritmetica -> Somador, Subtrador, AND e OR
module ula (
  input wire entrada1,
  input wire entrada2,
  input wire [0:3] seletor,
  output wire saida
);

  reg opAnd;
  reg opOr;
  reg opSoma;
  reg opSubtracao;
  reg opSLT;
  reg opNor;

  // Multiplexador da ULA:
  // -> 1º = AND
  // -> 2º = OR
  // -> 3º = ADD
  // -> 4º = SUB
  // -> 5º = SLT
  // -> 6º = NOR
  mux6_1 mux(
    opAnd,
    opOr,
    opSoma,
    opSubtracao,
    opSLT,
    opNor,
    seletor,
    saida
  );

  initial begin
    opAnd = entrada1 && entrada2;
    opOr = entrada1 || entrada2;
    opSoma = entrada1 + entrada2;
    opSubtracao = entrada1 - entrada2;
    opSLT = (entrada1 < entrada2);
    opNor = !(opOr);
  end
endmodule
