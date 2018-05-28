// `include "mux_6-1.v"

// Unidade Logica Aritmetica -> AND, OR, Soma, Subtracao, SLT e NOR
module alu (
  input wire [31:0] entrada1,
  input wire [31:0] entrada2,
  input wire [0:3] unidadeControle,
  output wire [0:31] saida,
  output reg zero
);

  reg [31:0] opAnd;
  reg [31:0] opOr;
  reg [31:0] opSoma;
  reg [31:0] opSubtracao;
  reg [31:0] opSLT;
  reg [31:0] opNor;

  // Multiplexador da ULA:
  // -> 1º = AND
  // -> 2º = OR
  // -> 3º = ADD
  // -> 4º = SUB
  // -> 5º = SLT
  // -> 6º = NOR
  always @(*) begin
    opAnd <= entrada1 & entrada2;
    opOr <= entrada1 | entrada2;
    opSoma <= entrada1 + entrada2;
    opSubtracao <= entrada1 - entrada2;
    opSLT <= (entrada1 < entrada2);
    opNor <= !(opOr);

    zero = (saida == 0);
  end

  mux32Bits6 mux(
    opAnd,
    opOr,
    opSoma,
    opSubtracao,
    opSLT,
    opNor,
    unidadeControle,
    saida
  );

endmodule
