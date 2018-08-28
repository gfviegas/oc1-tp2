module aluControl (
  input wire [1:0] aluOp,
  input wire [5:0] funct,
  output reg [3:0] saida
);

  always @(aluOp, funct) begin
    case(aluOp)
      0: saida = 0; //lw,sw
      1: saida = 1; //beq,bne
      2: begin
        case(funct)
          6'b10_0000: saida = 0; //add
          6'b10_0010: saida = 1; //sub
          6'b10_0100: saida = 2; //and
          6'b10_0101: saida = 3; //or
          6'b00_0000: saida = 4; //sll
          6'b00_0010: saida = 5; //srl
          6'b10_1010: saida = 6; //slt
        endcase
      end
    endcase
  end

  // Antes
  // always @ (aluOp or funct) begin
  //   if (aluOp[0] == 0)
  //     begin
  //       saida <= (aluOp[1] == 0) ? 4'b0010 : 4'b0110;
  //     end
  //   else
  //     begin
  //       case (funct[3:0])
  //         4'b0000 : saida <= 0; // Add
  //         4'b0010 : saida <= 1; // Sub
  //         4'b0100 : saida <= 2; // And
  //         4'b0101 : saida <= 3; // Or
  //         4'b1010 : saida <= 4; // SLT
  //         // QUAL É O VALOR BINARIO AQUI PRO NOR? 4'b1010 : saida <= 5; // NOR
  //       endcase
  //     end
  // end
endmodule
