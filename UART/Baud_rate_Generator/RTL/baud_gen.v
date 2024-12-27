`timescale 1ns / 1ps

//baud rate = 9600
//clock freaq = 48MHZ

//Wait clock = Clock ferq / BaudRate

module BAUD_GEN(input clk, rst,
                input [15:0]wait_clock, 
                output bclk);
                
                reg [15:0] ck_count;   //clock count has generate the pulse after 5000
                 
    always@(posedge clk or negedge rst)
        begin
            if(!rst)
                ck_count <= 0;
            else if(bclk)               //bclk becomes high after 5000 clock pulses
                ck_count <= 0;
            else
                ck_count <= ck_count + 1'b1;
        end
        
        assign bclk = (ck_count == wait_clock) ? 1'b1 : 1'b0;
endmodule
