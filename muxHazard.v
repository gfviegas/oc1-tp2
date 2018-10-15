module muxHazard (
    // INPUTS
    input wire control,

    // EX
    input wire regDest,
    input wire [1:0] aluOp,
    input wire aluSrc,
    // MEM
    input wire [2:0] memControlIdEx,
    // WB
    input wire [1:0] wbControlIdEx,

    // OUTPUTS
    // EX
    output reg hzdRegDest,
    output reg [1:0] hzdAluOp,
    output reg hzdAluSrc,
    // MEM
    output reg [2:0] hzdMemControlIdEx,
    // WB
    output reg [1:0] hzdWbControlIdEx
);

    always @(*) begin
      case (control)
        1'b0: begin
          hzdRegDest <= regDest;
          hzdAluOp <= aluOp;
          hzdAluSrc <= aluSrc;
          hzdMemControlIdEx <= memControlIdEx;
          hzdWbControlIdEx <= wbControlIdEx;
      end
        1'b1: begin
          hzdRegDest <= 0;
          hzdAluOp <= 0;
          hzdAluSrc <= 0;
          hzdMemControlIdEx <= 0;
          hzdWbControlIdEx <= 0;
      end
    endcase
  end
endmodule
