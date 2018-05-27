#! /bin/sh

iverilog -o output.out main.v
vvp output.out
