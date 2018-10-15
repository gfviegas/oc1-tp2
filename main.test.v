`include "main.v"

module main_testbench;
  wire reset = 0;
  reg clk = 0;
  wire [31:0] instr; // Instrucao -> Binario de 32 bits que será executado.

  initial begin
     $dumpfile("output.vcd");
     $dumpvars(0, main_testbench);
     # 20 $finish;
  end

  always #1 clk = !clk;
  main processador1 (.clock(clk), .instr(instr), .reset(reset));

  // initial
     // $monitor("At time %t, value = %h (%0d)", $time, value, value);
endmodule
