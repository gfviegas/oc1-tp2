// Unidade Logica Aritmetica -> AND, OR, Soma, Subtracao, SLT e NOR
module alu (
  input wire [31:0] entrada1,
  input wire [31:0] entrada2,
  input wire [0:3] unidadeControle,
  output reg [0:31] saida,
  output reg zero
);
  // Multiplexador da ULA:
  // -> 1º = ADD
  // -> 2º = SUB
  // -> 3º = AND
  // -> 4º = OR
  // -> 5º = SLT
  // -> 6º = NOR
  always @(*) begin
    case (unidadeControle)
      0: saida <= entrada1 + entrada2;
      1: saida <= entrada1 - entrada2;
      2: saida <= entrada1 & entrada2;
      3: saida <= entrada1 | entrada2;
      4: saida <= (entrada1 < entrada2);
      5: saida <= !(entrada1 | entrada2);
      6: saida <= 0;
    endcase

    zero = (saida == 0);
  end
endmodule
