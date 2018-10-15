module instructionMemory (
  input wire reset,
  input wire [31:0] readAddress,
  output reg [31:0] instruction
);

  reg [31:0] memory [0:5]; // 6 instrucoes de 32 bits

  integer i;

  initial begin
    $readmemb("instructions.bin", memory);
    $display("rdata:");
    for (i = 0; i < 6; i = i + 1)
      $display("%d: %b", i, memory[i]);
  end

  always @(readAddress) begin
    instruction <= memory[readAddress / 4];
    $display("# %t, RA: %d, %b", $time, readAddress, instruction);
  end

endmodule
