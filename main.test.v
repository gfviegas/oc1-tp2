`include "main.v"

module main_testbench;
  reg reset = 0;
  reg clk = 0;

  initial begin
     $dumpfile("output.vcd");
     $dumpvars(0, main_testbench);
     # 500 $finish;
  end

  always #1 clk = !clk;
  main processador1 (clk, reset);

  // initial
     // $monitor("At time %t, value = %h (%0d)", $time, value, value);
endmodule
