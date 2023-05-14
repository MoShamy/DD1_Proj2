module seq_det
(
input clk, rst, x,
output reg z
);
reg s0 = 2'b00;
reg s1= 2'b01;
reg s2= 2'b10;
reg [1 : 0] cur_s, next_s;
always@(*)
begin
casex (cur_s)
s0: if ( x == 1)
next_s = s1;
else
next_s = s0;
s1: if (x ==1)
next_s = s1;
else
next_s = s2;
s2: if (x == 1)
next_s = s1;
else
next_s = s0;
default : next_s = s0;
endcase
end
always@(*)
begin
if (cur_s == s2 && x)
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
