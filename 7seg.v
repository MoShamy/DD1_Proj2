module seg7(

    input clk,
    input  [15:0] sw,
    output reg [3:0] AN, 
    output reg [6:0] ledSEG
    );
    
    reg [26:0] secCount;
    wire secENAB;
    reg [15:0] numb; 
    reg [3:0] BCD;
    reg [19:0] refrsh; 
    wire [1:0] ledEN; 
                
    always @(posedge clk )
    begin
        begin
            if(secCount>=99999999) 
                 secCount <= 0;
            else
                secCount <= secCount + 1;
        end
    end 
    assign secENAB = (secCount==99999999)?1:0;
    always @(posedge clk )
    begin
       if(secENAB==1)
            numb <= sw;
    end
    always @(posedge clk )
    begin 
      
            refrsh <= refrsh + 1;
    end 
    assign ledEN = refrsh[19:18];
    always @(*)
    begin
        case(ledEN)
        2'b00: begin
            AN = 4'b0111; 
            BCD = numb/1000;
              end
        2'b01: begin
            AN = 4'b1011; 
            BCD = (numb % 1000)/100;
              end
        2'b10: begin
            AN = 4'b1101; 
            BCD = ((numb % 1000)%100)/10;
                end
        2'b11: begin
            AN = 4'b1110; 
            BCD = ((numb % 1000)%100)%10;
               end
        endcase
    end
    always @(*)
    begin
        case(BCD)
        4'b0000: ledSEG = 7'b0000001;  
        4'b0001: ledSEG = 7'b1001111; 
        4'b0010: ledSEG = 7'b0010010; 
        4'b0011: ledSEG = 7'b0000110; 
        4'b0100: ledSEG = 7'b1001100; 
        4'b0101: ledSEG = 7'b0100100; 
        4'b0110: ledSEG = 7'b0100000;
        4'b0111: ledSEG = 7'b0001111;
        4'b1000: ledSEG = 7'b0000000;  
        4'b1001: ledSEG = 7'b0000100; 
        default: ledSEG = 7'b0000001; 
        endcase
    end
 endmodule