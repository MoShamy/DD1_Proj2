`timescale 1ns / 1ps


module PushButtonDetector(
input x,
clk,
rst,
output z
    );
    
    wire clk_out,db_out,sync_out;
     clkdivider (clk,rst,clk_out);

    debouncer db(clk_out,rst,x,db_out);
    
    sync_total(db_out,clk_out,sync_out,rst);
    
    RED(clk_out,rst,sync_out,z);
    
    
    
    
    
endmodule
