/////
module clkdivider #(parameter n = 50000000)
(input clk, rst, output reg clk_out);
wire [31:0] count;
counter #(32,n) bc (clk, rst, 1,count);
always @ (posedge clk, posedge rst) begin
if (rst)
clk_out <= 0;
else if (count == n-1)
clk_out <= ~ clk_out;
end
endmodule
