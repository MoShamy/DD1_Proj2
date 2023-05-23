

module edge_detect(input clk, rst, level, output tick);
parameter [1:0] zero= 2'b00, edg=2'b01, one=2'b10;
reg [1:0] state, nextState;
// Next state generation (combinational logic)
always @ (level or state)
case (state)
zero: if (level==0) nextState = zero;
 else nextState = edg;
edg: if (level==0) nextState = zero;
 else nextState = one;
one: if (level==0) nextState = zero;
 else nextState = one;
default: nextState = zero;
endcase
// State register
// Update state FF’s with the triggering edge of the clock
always @ (posedge clk or posedge rst) begin
if(rst) state <= zero;
else state <= nextState;
end
// output generation (combinational logic)
assign tick = (state == edg);
endmodule

///////////////////////////////////////////////////////////////////////////



module debouncer(input clk, rst, in, output out);
reg q1,q2,q3;
always@(posedge clk, posedge rst) begin
 if(rst == 1'b1) begin
 q1 <= 0;
 q2 <= 0;
 q3 <= 0;
 end
 else begin
 q1 <= in;
 q2 <= q1;
 q3 <= q2;
 end
end
assign out = (rst) ? 0 : q1&q2&q3;
endmodule



/////////////////////////////////////////////////////////////////////



module sync(input clk,D,rst, output reg Q2);
reg Q;
always @(posedge clk or posedge rst)begin
if(rst)begin
Q<=0;
Q2<=0;
end
else begin
Q<=D;
Q2<=Q;
end
end
endmodule

/////////////////////////////////////////////////////////////////////////

module clockDivider #(parameter n = 5000000)
(input clk, rst, output reg clk_out);
reg [31:0] count;
// Big enough to hold the maximum possible value
// Increment count 
always @ (posedge clk, posedge rst) begin 
if (rst == 1'b1) // Asynchronous Reset 
 count <= 32'b0;
else if (count == n-1)
 count <= 32'b0;
else
 count <= count + 1; 
end
// Handle the output clock 
always @ (posedge clk, posedge rst) begin 
if (rst) // Asynchronous Reset 
 clk_out <= 0;
else if (count == n-1)
 clk_out <= ~ clk_out; 
end
endmodule 


/////////////////////////////////////////////////////////////////////////////


module pushDetect(input a,input clk,input rst,output z );
wire clkout,w1,w2;
clockDivider #(500000) clkDiv (clk,rst,clkout);
debouncer db (clkout,rst,a,w1);
sync s(clkout,w1,rst,w2);
edge_detect ed(clk,rst,w2,z);
endmodule



