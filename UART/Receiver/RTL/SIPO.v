`timescale 1ns/1ps

module SIPO #(parameter WIDTH = 8)(input RX_data,
                                    input clk, rst,
                                    input shift_bit,
                                    output reg [WIDTH - 1 : 0]data_out);
    
    reg [WIDTH - 1 : 0]out;
   // reg delayed_bit;                                    
    always@(posedge clk or negedge rst)
        begin
            if(!rst)
                begin
                     data_out <= 8'b0;
                     out <= 8'b0;
                   // delayed_bit <= 1'b0;
                end 
            else if(shift_bit)
                out <= {RX_data,out[WIDTH - 1 : 1]};
            else
                data_out <= out;
        end
endmodule