`timescale 1ns / 1ps

module STOP_CHECKER #(parameter WIDTH = 8)(input clk, rst,
                                            input [WIDTH - 1 : 0]data,
                                            input RX_data,
                                            input check_stop,
                                            output reg stop_bit_err,
                                            output [WIDTH - 1 : 0]data_out);
                                            
    reg check;
    
    assign data_out = data;
                                                
    always@(posedge clk or negedge rst)
        begin
            if(!rst)
              stop_bit_err <= 1'b0;
              
            else if(check_stop)
                begin
                    if(RX_data == 1'b1)
                        stop_bit_err <= 1'b0;
                    else
                        stop_bit_err <= 1'b1;
                end
        end
endmodule
