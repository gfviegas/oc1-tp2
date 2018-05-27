#! /bin/sh

iverilog -o output.test.out main.test.v main.v
vvp output.test.out -lxt2
gtkwave output.vcd &
