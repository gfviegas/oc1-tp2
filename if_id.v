module IF_ID (
  input wire [31:0] pc,
  input wire [31:0] instruction,
  input wire clock,
  output wire [0:31] outPc,
  output wire [0:31] outInstruction
);

    initial begin
        pc <= 0;
        instruction <= 0;
    end

    always @(posedge clock) begin
        outPc <= pc;
        outInstruction <= instruction;
    end

endmodule
