module signExtend (
  input wire [15:0] entrada,
  output wire [31:0] saida
);

  reg [31:0] aux;

  always @(*) begin
      aux = 32'b0 + entrada;
  end

  assign saida = aux;
endmodule
