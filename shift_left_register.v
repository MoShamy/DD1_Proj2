/* when the load input is asserted, the module loads the multiplicand value into the register q.
Otherwise, it performs a left shift on the value stored in q, 
effectively shifting it one bit to the left and filling the rightmost bit with zero. 
The result is stored back in q on each positive edge of the clock.*/

module shift_left_register(
  input [15:0] muliplicand,
  input load,
  input clk,
  output reg [15:0] q
  );

always @(posedge clk) 
  begin 
    if(load)
      q <= muliplicand;
    else 
      q <= {q[14:0], 1'b0};
  end
endmodule
