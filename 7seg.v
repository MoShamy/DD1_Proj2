/* this code implements a simple 7-segment display controller that takes a numerical input from the "sw" switch and
 displays it on a 4-digit 7-segment display.
 The digits can be shifted and displayed in different combinations depending on the signals received. */

 /*Inside the always block triggered by the start, SL, or SR signals, the digits of the number "numb"
  are extracted and stored in registers d0, d1, d2, d3, and d4. Depending on the signal (start, SL, or SR), 
 different combinations of these digits are assigned to registers x0, x1, and x2. This is done for shifting*/

module seg7(
    input clk,
    input start,
    input sign,
    input SL,                //shift_left
    input SR,               //shift_right
    input  [15:0] sw,      //product of multiplication 
    output reg [3:0] AN, 
    output reg [6:0] ledSEG
    );
    
    reg [26:0] secCount;
    wire secENAB;
    reg [15:0] numb; 
    reg [3:0] BCD;
    reg [3:0] d0;
    reg [3:0] d1;
    reg [3:0] d2;
    reg [3:0] d3;
    reg [3:0] d4;
    reg [3:0] temp;
    reg [19:0] refrsh; 
    wire [1:0] ledEN; 
     
    
                
    always @(posedge clk ) 
    begin
        begin
            if(secCount>=99999999) 
                 secCount <= 27'b0;
            else
                secCount <= secCount + 1'b1;
        end
    end 
    
    assign secENAB = (secCount==99999999) ? 1'b1 : 1'b0;

    always @(posedge clk )
    begin
       if(secENAB == 1)
            numb <= sw;
    end

    always @(posedge clk)
    begin 
       refrsh <= refrsh +1'b1;
    end 


    assign ledEN = refrsh[19:18];
    
    reg [3:0] x0,x1,x2,x3,x4;
    always @(posedge start or posedge SL or posedge SR)
    begin
        if(start) 
        begin
            d0 = numb/10000;
            d1 = (numb % 10000)/1000;
            d2 = ((numb % 10000)%1000)/100;
            d3 = (((numb % 10000)%1000)%100)/10;
            d4 = (((numb%10000)%1000)%100)%10;
            x0 = d1;
            x1 = d2;
            x2 = d3;
        end else if(SR) 
        begin 
            x0 = d0;
            x1 = d1;
            x2 = d2;
        end else if(SL) 
        begin
            x0 = d2;
            x1 = d3;
            x2 = d4;
        end  
    end
    
   
    
    always @ (*) 
    begin
        case(ledEN)
        2'b00: begin
            AN = 4'b0111; 
            BCD = (sign) ? 4'b1011: 4'b1010;
        end
        2'b01: begin
            AN = 4'b1011; 
            BCD = x0;
              end
        2'b10: begin
            AN = 4'b1101; 
            BCD = x1;
        end
        2'b11: begin
            AN = 4'b1110; 
            BCD = x2;
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
        4'b1011: ledSEG = 7'b1111110;  //neg sign
        4'b1010: ledSEG = 7'b1111111;  // empty (No signs)
        default: ledSEG = 7'b0000001; 
        endcase
    end
 endmodule


