/*The code uses sequential logic with a clock edge-triggered always block. When start is asserted,
the multiplication process begins. Initially, the product is reset to zero,
done is set to zero, and the sign flag is determined based on the sign of the inputs (multiplicand and multiplier).
If either multiplicand or multiplier is negative, the corresponding
input is converted to its two's complement representation
by performing bitwise negation and adding 1.
This ensures correct handling of negative numbers during the multiplication.During each clock cycle, 
the shifted values of the multiplicand and multiplier (w1 and w2) are computed using the shift registers. 
The product is updated by adding w1 (multiplicand) to the product if the least significant bit of w2 is 1.
This multiplication step is repeated for 8 clock cycles, representing the 8 bits of the multiplier.
The count counter is used to keep track of the current cycle of multiplication. When count reaches 7,
it means all 8 bits of the multiplier have been processed, and the multiplication is considered complete.
The done flag is then set to indicate the completion. */


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
  reg [3:0]  count;
  reg [7:0] plicand;
  reg [7:0] pliar;

  shift_left_register cand (.muliplicand({8'b0,plicand}), .load(start), .clk(clk), .q(w1));  
  shift_right_register plier (.multiplier(pliar), .load(start), .clk(clk), .q(w2));
  modulo_9_counter cnrt (.clk(clk), .rst(start), .en(~start) , .count(count));

  always @ (posedge clk) 
  begin 
    if (start) 
    begin 
    product = 16'b0;
    done = 1'b0;
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
      if(count == 4'd7) 
        done = 1'b1;

      product <= product + (w2[0]? w1 : 16'b0);
    end

  end
endmodule
