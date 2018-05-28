`include "mux_6-1.v"

// Unidade Logica Aritmetica -> AND, OR, Soma, Subtracao, SLT e NOR
module ula (
  input wire entrada1,
  input wire entrada2,
  input wire [0:3] unidadeControle,
  output wire [0:31] saida,
  output wire zero
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
  initial begin
    opAnd = entrada1 & entrada2;
    opOr = entrada1 | entrada2;
    opSoma = entrada1 + entrada2;
    opSubtracao = entrada1 - entrada2;
    opSLT = (entrada1 < entrada2);
    opNor = !(opOr);
  end

  mux6_1 mux(
    opAnd,
    opOr,
    opSoma,
    opSubtracao,
    opSLT,
    opNor,
    unidadeControle,
    saida
  );

  assign zero = (saida == 0);
endmodule
