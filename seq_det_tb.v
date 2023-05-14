// file: seg_tb.v
// author: @yehia1233
// Testbench for seg

`timescale 1ns/1ns

module seq_det_tb;
	// Declarations
	reg  x;
	reg  clk;
	reg  rst;
	wire  z;


seq_det DUT(clk, rst, x, z);
reg [0:15] pattern = 16'b0101001101101011;
integer i;
initial begin
 clk = 1;
 forever #25 clk=~clk;
end
initial begin
 x=0; rst=1;
 #25
 rst=0;
for ( i = 0; i <= 15; i = i + 1 ) begin
#50 x = pattern[i];
 end
end
endmodule


