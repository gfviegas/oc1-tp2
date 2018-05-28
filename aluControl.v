module aluControl (
  input wire [1:0] aluOp,
  input wire [5:0] funct,
  output wire [3:0] saida
);

  always @ (opCode or funct) begin
    if (aluOp[0] == 0)
      begin
        saida = (aluOp[1] == 0) ? 4'b0010 : 4'b0110;
      end
    else
      begin
        case (funct[3:0])
          4'b0000 : saida <= 4'b0010;
          4'b0010 : saida <= 4'b0110;
          4'b0100 : saida <= 4'b0000;
          4'b0101 : saida <= 4'b0001;
          4'b1010 : saida <= 4'b0111;
        endcase
      end
  end
endmodule
