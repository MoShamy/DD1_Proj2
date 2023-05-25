/* when the load input is asserted, the module loads the multiplicand value into the register q.
Otherwise, it performs a right shift on the value stored in q, 
effectively shifting it one bit to the right and filling the leftmost bit with zero. 
The result is stored back in q on each positive edge of the clock.*/

module shift_right_register(
  input [7:0] multiplier,
  input load,
  input clk,
  output reg [7:0] q
  );

always @(posedge clk)
  begin 
  if(load)
    q <= multiplier;
  else begin
    q <= {1'b0,q[7:1]};
  end 
end
endmodule