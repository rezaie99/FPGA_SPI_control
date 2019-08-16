***** Verilog start*********************************


module top(rst, RGB0, RGB1, RGB2, a0, a1, a2);
input rst;
output RGB0, RGB1, RGB2, a0, a1, a2;

reg [23:0] count;
reg a0, a1, a2 ;

HSOSC OSCInst0 (
.CLKHFEN(1'b1),
.CLKHFPU(1'b1),
.CLKHF(oclk)
);
defparam OSCInst0.CLKHF_DIV = "0b01";

always @ (posedge oclk or posedge rst)
       begin
               if (rst)
                       count <= 24'd0;        
               else
                       count <= count + 1 ;
       end        

always @ (posedge oclk)
       begin 
               if      (count == 24'b110000000000000000000000) 
                        a0 <= 1'b1 ;
               else if (count == 24'b110011111111111111111111)
                        a0 <= 1'b0 ;
                        
               if      (count == 24'b100000000000000000000000) 
                        a1 <= 1'b1 ;
               else if (count == 24'b100011111111111111111111)
                        a1 <= 1'b0 ;
                        
               if      (count == 24'b010000000000000000000000) 
                        a2 <= 1'b1 ;
               else if (count == 24'b010011111111111111111111)
                        a2 <= 1'b0 ;
       end                

       RGB inst1(        
                                       .CURREN(1'b1), 
                                       .RGBLEDEN(1'b1), 
                                       .RGB0PWM(a0), 
                                       .RGB1PWM(a1), 
                                       .RGB2PWM(a2), 
                                       .RGB2(RGB2), 
                                       .RGB1(RGB1), 
                                       .RGB0(RGB0)
                                       );
       defparam inst1.CURRENT_MODE = 1 ;
       defparam inst1.RGB0_CURRENT = "0b000011" ;
       defparam inst1.RGB1_CURRENT = "0b000111" ;
       defparam inst1.RGB2_CURRENT = "0b001111" ;

endmodule



***** Verilog end***********************************
