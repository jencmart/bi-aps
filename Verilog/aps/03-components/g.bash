#!/bin/bash

rm a.out
rm test
rm bin/Jenc_Martin*

echo "building cpu..."
iverilog cpu.v cpu_tb.v
echo "building p1..."
./acc < src/Jenc_Martin_prog1.s > bin/Jenc_Martin_prog1.hex
echo "building p2..."
./acc < src/Jenc_Martin_prog2.s > bin/Jenc_Martin_prog2.hex
echo "generating test file..."
./a.out
echo "***DONE***"
echo "starting simulation..."
gtkwave test
