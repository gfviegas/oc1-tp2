module dataMemory (
  input wire [31:0] address,
  input wire [31:0] writeData,
  input wire memRead,
  input wire memWrite,
  output reg [31:0] readData
);

  reg [31:0] memory [0:15]; // 16 elementos de 32 bits de memoria

  initial begin
    readData <= 0;
  end

  always @(memRead or memWrite) begin
    if (memWrite)
      begin
        memory[address] <= readData;
      end

    if (memRead)
      begin
        readData <= memory[address];
      end
  end


endmodule
