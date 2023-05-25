/*This module is mainly reposible for creating a parameterized counter that is used later in the modulo_9_counter module 
*/

module counter #(parameter x= 4, parameter n = 10)
(
    input clk, reset, en, output reg [x-1:0]count
);

always @(posedge clk, posedge reset) 
    begin
        if (reset == 1'b1)
            count <= 3'd0; 
        else if (en)
        begin
            if(count == n-1)
                count <= 3'd0; 
            else
                count <= count + 1'b1; 
        end
    end
endmodule
