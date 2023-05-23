


module modulo_9_counter(
input clk, rst, en, output [3:0]count
);
counter #(4,9) bc (clk, rst, en,count);
endmodule
