
module shift_right_register(
input [7:0] multiplier,
input load,
input clk,
output reg [7:0] q);

 
always @(posedge clk) begin 
if(load)
  q <= multiplier;
else begin
    q <= {1'b0,q[7:1]};

end 
end
endmodule
