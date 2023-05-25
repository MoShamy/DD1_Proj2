/* This module takes an instance from module counter to initiate a counter that counts from 0 to 8 */

module modulo_9_counter
(
    input clk, rst, en, output [3:0]count
);
counter #(4,9) bc (.clk(clk), .reset(rst), .en(en), .count(count));
endmodule

