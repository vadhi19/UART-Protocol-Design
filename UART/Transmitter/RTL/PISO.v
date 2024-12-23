`timescale 1ns / 1ps

module PISO #(parameter WIDTH = 8)(input clk, rst,
            input [WIDTH - 1 : 0]data,
            input shift_bit,
            input load_bit,
            output data_out);
            
    reg [WIDTH - 1 : 0] out;
    
    assign data_out = out[0];
            
    always@(posedge clk, negedge rst)
        begin
            if(!rst)
                out <= 8'b0;
            else if(load_bit)
                out <= data;
            else if(shift_bit)
                out <= {1'b0,out[7:1]};
        end
        
endmodule
