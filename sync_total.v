`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2023 05:58:21 PM
// Design Name: 
// Module Name: sync_total
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sync_total(
input D, 
input clk,
input rst,
output Q
    );
    
wire w;


Dff d1(D,clk,rst,w);
Dff d2(w,clk,rst,Q);


endmodule
