#! /bin/sh

iverilog -o output.vvp main.v
vvp output.vvp
