
module Main(
input [7:0] plicand,
input [7:0] pliar,
input start,
input clk,
input SL,
input SR,
output reg [3:0] AN, 
output reg [6:0] ledSEG,
output done
    );
    
    
    wire clk_out,SL_out,SR_out;
    wire [15:0] product;
    wire [3:0] AN;
    wire [6:0] ledSEG;
    
     
     pushDetect pbStart(start,clk,rst,start_out);
     pushDetect pbSL (SL,clk,rst,SL_out);
     pushDetect pbSR (SR,clk,rst,SR_out);
     
     Multiplier mult(plicand,pliar,start,clk,product,done);
     seg7 seg7(clk,start_out, SL_out, SR_out, product,AN,ledSEG);
     
     
endmodule
