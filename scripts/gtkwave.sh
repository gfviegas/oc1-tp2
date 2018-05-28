#! /bin/sh

iverilog -o output.test.vvp main.test.v
vvp output.test.vvp -lxt2
if [ -z "$1" ]; then
  gtkwave output.vcd &
fi
