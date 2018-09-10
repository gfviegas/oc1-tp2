// Multiplexador de 3 entradas simples.
//
// MUX DE ENTRADAS DE 32 BITS
module mux32Bits2 (
  input wire [31:0] entrada1,
  input wire [31:0] entrada2,
  input wire [31:0] entrada3,
  input wire [1:0] seletor,
  output reg [31:0] saida
);

  always @(*) begin
    case (seletor)
      2'b00 : saida <= entrada1;
      2'b01 : saida <= entrada2;
      2'b10 : saida <= entrada3;
    endcase
  end

endmodule
