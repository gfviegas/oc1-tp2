module signExtend (
  input wire [15:0] entrada,
  output wire [31:0] saida
);

  assign saida = {{16{entrada[15]}}, {entrada}};
endmodule
