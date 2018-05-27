#! /bin/sh

iverilog -o output.test.vvp main.test.v main.v
vvp output.test.vvp -lxt2
gtkwave output.vcd &
