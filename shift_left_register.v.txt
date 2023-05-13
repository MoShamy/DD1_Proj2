


module shift_left_register(
input [15:0] muliplicand,
input load,
input clk,
output reg [15:0] q);

 
always @(posedge clk) begin 
if(load)
  q <= muliplicand;
else begin
    q <= {q[14:0], 1'b0};

end 
end



endmodule
