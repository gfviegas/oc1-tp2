module aluControl (
  input wire [4:0] opCode,
  input wire [5:0] funct,
  output wire [3:0] saida
);

  always @ (opCode or funct) begin
    if (opCode == 0)
      begin // Tipo R


      end
    else
      begin

      end
  end
endmodule
