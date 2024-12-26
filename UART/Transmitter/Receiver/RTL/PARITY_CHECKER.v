`timescale 1ns / 1ps

module PARITY_CHECKER #(parameter WIDTH = 8)(input clk, rst,
                                            input RX_data,
                                            input parity_load,
                                            input [WIDTH - 1 : 0] data,
                                            output reg parity_bit_err,
                                            output [WIDTH - 1 : 0]data_out);

    reg parity_check;
    wire internal_parity;
    
    assign internal_parity = ^data;
    
    assign data_out = data; 

   always @(posedge clk or negedge rst)
    begin
        if (!rst)
        begin
            parity_bit_err <= 1'b0;  
        end
        
        else if (parity_load)
                parity_check <= RX_data;  
                      
        else if(|data != 1'b0)
            begin
                if (parity_check == internal_parity)
                    parity_bit_err <= 1'b0;
                else
                    parity_bit_err <= 1'b1;
            end
    end
    
endmodule

