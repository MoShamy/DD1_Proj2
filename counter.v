
module counter #(parameter x= 4, parameter n = 10)
(
input clk, reset, en, output reg [x-1:0]count
);

always @(posedge clk, posedge reset) begin
if (reset == 1)
count <= 3'd0; // non-blocking assignment // initialize flip flophere
else if (en )begin
if(count == n-1)
count <= 3'd0; 
else
count <= count + 1; 
end
end
endmodule
