
module Multiplier( 
input [7:0] multiplicand,
input [7:0] multiplier,
input  start,
input clk, 
output reg [15:0] product,
output done
  );
wire [15:0] w1; //multiplicand 
wire [7:0] w2;  //multiplier
wire [3:0] count;
reg d;

shift_left_register cand ( {8'b0,multiplicand} , start, clk, w1);  //start -> enable WE NEED TO CHANGE THE CLOCK
shift_right_register plier (multiplier, start, clk, w2);
modulo_9_counter cnrt (clk, start, ~start ,count);
assign done=0;
Dff DFF(d,clk,start,done);

always @ (posedge clk) begin 
if (start)  begin 
     product = 16'b0;
      d=0;

  end else begin
      d = (count == 5 || count == 6) ? 1 : done;

     product <= product + (w2[0]? w1 : 16'B0);

     
end

end
endmodule

