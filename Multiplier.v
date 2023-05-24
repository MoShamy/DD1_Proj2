
module Multiplier( 
input [7:0] multiplicand,
input [7:0] multiplier,
input  start,
input clk, 
output reg [15:0] product,
output reg done,
output reg sign
  );
wire [15:0] w1; //multiplicand 
wire [7:0] w2;  //multiplier
wire [3:0] count;
reg [3:0]count;
reg [7:0] plicand;
reg [7:0] pliar;

shift_left_register cand ( {8'b0,plicand} , start, clk, w1);  //start -> enable WE NEED TO CHANGE THE CLOCK
shift_right_register plier (pliar, start, clk, w2);
modulo_9_counter cnrt (clk, start, ~start ,count);

always @ (posedge clk) 
begin 
    if (start) 
     begin 
         product = 16'b0;
         done = 0;
         sign = multiplicand[7] ^ multiplier[7];
         
             if(multiplicand[7]) 
             begin
                plicand = ~multiplicand +1'b1; //2s comp if input is negative
              end else
              plicand = multiplicand;
             
              if(multiplier[7])
               begin
                pliar = ~multiplier +1'b1; //2s comp if input is negative
              end else
              pliar = multiplier;
        
        end else begin
                if(count==7) 
                 done=1;
                
             product <= product + (w2[0]? w1 : 16'B0);
    
         
                end

end


endmodule

