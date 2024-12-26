`timescale 1ns / 1ps

module DEMUX(input RX_data,
             input [1:0] sel,
             output reg start, data, parity, stop);
             
     parameter START = 2'b00,
                DATA = 2'b01,
                PARITY = 2'b10,
                STOP = 2'b11;
             
    always@(*)
        begin
            case(sel)
                
                START : start <= RX_data;
                DATA : data <= RX_data;
                PARITY : parity <= RX_data;
                STOP : stop <= RX_data;
                default : {start,data,parity,stop} = 0;
            endcase
        end                     
endmodule
