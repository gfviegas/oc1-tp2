module aluControl (
  input wire [1:0] aluOp,
  input wire [5:0] funct,
  output reg [3:0] saida
);

  always @ (aluOp or funct) begin
    if (aluOp[0] == 0)
      begin
        saida <= (aluOp[1] == 0) ? 4'b0010 : 4'b0110;
      end
    else
      begin
        case (funct[3:0])
          4'b0000 : saida <= 0; // Add
          4'b0010 : saida <= 1; // Sub
          4'b0100 : saida <= 2; // And
          4'b0101 : saida <= 3; // Or
          4'b1010 : saida <= 4; // SLT
          // QUAL É O VALOR BINARIO AQUI PRO NOR? 4'b1010 : saida <= 5; // NOR
        endcase
      end
  end
endmodule
