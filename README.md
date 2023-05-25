# DD1_Proj2
This is a Sequential Signed Multiplier, Implemented using the Shift-Add algorithm, in Verilog.

Team members:
Mostafa Elshamy
Salma Elsayed
Yehia Ragab

Instructor: Dr.Mohamed Shalan

This project was created by the above mentioned team, to fullfill the requirmenets of 
CSCE 2301 - "Digital Design 1" at The American University in Cairo.

Loading the file:

This project was designed for implementation on the Basys-3 FPGA board, by Xilinx. To run this project, load all .v files into Vivado as 
design sources, and main_cnst.xdc as the target constraint file. After synthesizing, implementing, and generating a bitstream, you will
be able to program this project onto the Basys board.

Using the multiplier:
The multiplier recieves its multiplicand and multiplier in binary form, using the 16 switches of the FPGA. The left 8 switches are used
for the 8-bit binary input of the multiplier, an the left most 8 switches for the multiplicand. To input a positive number, enter its
binary representation, to enter a negative number, enter its 2's complement. After entering the numbers you would like to multiply,
press the central push button (Btnc) to start multiplying. 3 digits will appear on the right-most 7-seg displays. Knowing that 
the multiplication could result in up to a 5 digit output, you may scroll through the digits using the right and left buttons.

The left-most display will indicate the sign of the output, showing a blank display for positive numbers, and a negative sign
for negative numbers.


The right-most LED indicates when multiplication is complete, which occurs 8 clock cycles after begining multiplication.


Other files:
Block Diagram.PDF : This was the origional schematic block diagram, that the team came up with. It acted as a guide for the remainder 
of the porject, but is not neccesarily implemented as is. Many features where added, and removed during implementation.

proj_sub_2_final.circ : This file was created using Logisim Evolution, and is a simulation of the add-shift algorithm.
It is unsigned, and without a display, but was a very useful guide when creating the Verilog implementation.


