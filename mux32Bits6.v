// Multiplexador de 6 entradas simples.

module mux32Bits6 (
  input wire [31:0] entrada1,
  input wire [31:0] entrada2,
  input wire [31:0] entrada3,
  input wire [31:0] entrada4,
  input wire [31:0] entrada5,
  input wire [31:0] entrada6,
  input wire [3:0] seletor,
  output reg [0:31] saida
);

  always @ (*) begin
    case (seletor)
      4'b0000 : saida <= entrada1;
      4'b0001 : saida <= entrada2;
      4'b0010 : saida <= entrada3;
      4'b0110 : saida <= entrada4;
      4'b0111 : saida <= entrada5;
      4'b1100 : saida <= entrada6;
    endcase
  end
endmodule
