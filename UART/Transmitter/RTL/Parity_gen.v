`timescale 1ns / 1ps

module Parity_gen #(parameter WIDTH = 8)(input clk, rst,
                                            input load_bit,
                                            input [WIDTH - 1 : 0]data,
                                            output reg p_out);
                                            
    reg [WIDTH - 1 : 0]parity_bit;
                                            
    always @(posedge clk, negedge rst)
            begin
                if(!rst)
                    parity_bit = 1'b0;
                else if(load_bit)
                    parity_bit <= data;
                else
                    p_out = ^parity_bit;
            end
                  
endmodule
