
module Main(
input [7:0] plicand,
input [7:0] pliar,
input start,
input clk,
output reg [3:0] AN, 
output reg [6:0] ledSEG,
output done
    );
    
    
    wire clk_out;
    wire [15:0] product;
    wire [3:0] AN;
    wire [6:0] ledSEG;
    
     clkdivider clkdiv ( clk, start,  clk_out);
     PushButtonDetector (start,clk_out,rst,start_out);
     Multiplier mult(plicand,pliar,start,clk,product,done);
     seg7(clk,product,AN,ledSEG);
     
     
endmodule
