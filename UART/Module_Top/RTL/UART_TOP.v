`timescale 100ns / 1ps

module UART_TOP #(parameter WIDTH = 8)(input clk, rst,
                                        input [15:0] wait_clock,
                                        input [WIDTH - 1 : 0]TX_data_in,
                                        input start,
                                        output busy,
                                        output parity_bit_err,
                                        output stop_bit_err,
                                        output [WIDTH - 1 : 0]RX_data_out);
                                        
    wire data_out;
    
    wire clk_wire;
    
    BAUD_GEN BG(.clk(clk), .rst(rst), .wait_clock(wait_clock), .bclk(clk_wire));
    
    UART_TX #(.WIDTH(WIDTH)) TX(.clk(clk_wire), .rst(rst), .start(start), .busy(busy), .data(TX_data_in), .data_out(data_out));
    
    UART_RX #(.WIDTH(WIDTH)) RX(.clk(clk_wire), .rst(rst), .RX_data(data_out), .RX_data_out(RX_data_out), 
                                    .stop_bit_err(stop_bit_err), .parity_bit_err(parity_bit_err));
endmodule
