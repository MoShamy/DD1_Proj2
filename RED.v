module RED
(
input clk,
input rst,
input x,
output reg z
);

reg s0 = 1'b0;
reg s1=1'b1;
reg  cur_s;
reg next_s;
always@(*)
begin
casex (cur_s)
s0: if ( x == 1)
next_s = s1;
else
next_s = s0;
s1: if (x ==1)
next_s = s1;

default : next_s = s0;
endcase
end
always@(*)
begin
if (cur_s == s1 && x)
z = 1;
else
z = 0;
end
always@(posedge clk, posedge rst)
begin
if (rst == 1)
cur_s <= s0;
else
cur_s <= next_s;
end
endmodule