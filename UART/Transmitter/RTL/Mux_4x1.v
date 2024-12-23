`timescale 1ns / 1ps

module Mux_4x1(input [1:0]sel,
                input in0, in1, in2, in3,
                output reg data_out);

    parameter START_BIT = 2'b00,
              DATA_BIT = 2'b01,
              PARITY_BIT = 2'b10,
              STOP_BIT = 2'b11;
              
    always@(*)
        begin
                case(sel)
                    START_BIT  : data_out <= in0;
                    DATA_BIT   : data_out <= in1;
                    PARITY_BIT : data_out <= in2;
                    STOP_BIT   : data_out <= in3;
                    default    : data_out <= 1'b0;
                endcase
        end
endmodule
