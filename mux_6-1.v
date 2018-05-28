// Multiplexador de 6 entradas simples.
module mux6_1 (
  input wire entrada1,
  input wire entrada2,
  input wire entrada3,
  input wire entrada4,
  input wire entrada5,
  input wire entrada6,
  input wire [3:0] seletor,
  output reg [0:31] saida
);

  always @ (entrada1 or entrada2 or entrada3 or entrada4 or entrada5 or entrada6 or seletor) begin
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
