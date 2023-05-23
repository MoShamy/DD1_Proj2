module seg7(

    input clk,
    input start,
    input SL,
    input SR,
    input  [15:0] sw,
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
    wire [3:0] sign;
     
    assign sign = 4'b1011;
                
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
    
   
    //array of all the Ds to play with 
    always @(posedge start or posedge SL or posedge SR)begin
    if(start) begin
         d0 = numb/10000;
         d1 = (numb % 10000)/1000;
         d2 = ((numb % 10000)%1000)/100;
         d3 = (((numb % 10000)%1000)%100)/10;
         d4 = (((numb%10000)%1000)%100)%10;
    end else if(SR) begin
 
        temp = d4;
        d4 = d3;
        d3 = d2;
        d2 = d1;
        d1 = d0;
        d0 = temp;
     end else if(SL) begin
    
        temp = d0;
        d0 = d1;
        d1 = d2;
        d2 = d3;
        d3 = d4;
        d4= temp;
    end  
    
    
    end
    
   
    
    always @ (*) begin
        case(ledEN)
        2'b00: begin
            AN = 4'b0111; 
            BCD = sign;
              end
        2'b01: begin
            AN = 4'b1011; 
            BCD = d0;
              end
        2'b10: begin
            AN = 4'b1101; 
            BCD = d1;
                end
        2'b11: begin
            AN = 4'b1110; 
            BCD = d2;
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
        4'b1011: ledSEG = 7'b1111110; 
        default: ledSEG = 7'b0000001; 
        endcase
    end
 endmodule

