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
    output wire hzdRegDest,
    output wire [1:0] hzdAluOp,
    output wire hzdAluSrc,
    // MEM
    output wire [2:0] hzdMemControlIdEx,  
    // WB
    output wire [1:0] hzdWbControlIdEx
);

    // Setting the output based on control signal;
    always @ (*) begin
        case (control)
            1'b0: begin
                hzdRegDest <= regDest;
                hzdAluOp <= hzdAluOp;
                hzdAluSrc <= hzdAluSrc;
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
