module fowarding(
  input wire clock,

  // INPUTS
  input wire rs,
  input wire [4:0] rt,

  // EX/MEM
  input wire rdExMem,
  input wire [2:0] memControlInput,

  // MEM/WB
  input wire [1:0] wbControlInput,
  input wire rdMemWb,


  // OUTPUTS
  output reg [1:0] fowardA,
  output reg [1:0] fowardB
);

  initial begin
    fowardA <= 0;
    fowardB <= 0;
  end

  always @(posedge clock) begin
    if ((wbControlInput) && (rdMemWb != 0) && (rdMemWb == rs)) begin
      fowardA <= 01;
    end

    if ((wbControlInput) && (rdMemWb != 0) && (rdMemWb == rt)) begin
      fowardB <= 01;
    end
  end

endmodule
