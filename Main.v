/* The main module combines all other modules together and this is the one to be simulated and implemented */

module Main(
    input clk,
    input start,
    input [7:0] plicand,
    input [7:0] pliar,
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
    wire sign;
    
     
    pushDetect pbStart(.a(start), .clk(clk), .rst(rst), .z(start_out));
    pushDetect pbSL (.a(SL), .clk(clk), .rst(rst), .z(SL_out));
    pushDetect pbSR (.a(SR), .clk(clk), .rst(rst), .z(SR_out));
    Multiplier mult(.multiplicand(plicand), .multiplier(pliar), .start(start), .c;l(clk), .product(product), .done(done), .sign(sign));
    seg7 seg7(.clk(clk), .start(start_out), .sign(sign), .SL(SL_out), .SR(SR_out), .sw(product), .AN(AN), .ledSEG(ledSEG));

endmodule