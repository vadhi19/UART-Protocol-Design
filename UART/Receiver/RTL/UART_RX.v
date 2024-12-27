`timescale 1ns / 1ps

module UART_RX #(parameter WIDTH = 8)(input clk, rst,
                                        input RX_data,
                                        output [WIDTH - 1 : 0]RX_data_out,
                                        output stop_bit_err,
                                        output parity_bit_err);
                                        
    wire shift_bit_wire;
    wire parity_load_wire;
    wire start_bit_wire;
    
    wire [WIDTH - 1 : 0]d2p, p2s;
                              
    detect_start DETECT(.RX_data(RX_data), .start_bit_detect(start_bit_wire));
   
    RX_FSM FSM(.clk(clk), .rst(rst), .start_bit_detect(start_bit_wire), .parity_bit_err(parity_bit_err),
                                .parity_load(parity_load_wire), .shift_bit(shift_bit_wire), .check_stop(check_stop_wire));
  
    SIPO #(.WIDTH(WIDTH)) SIPO(.clk(clk), .rst(rst), .RX_data(RX_data), .shift_bit(shift_bit_wire), .data_out(d2p));
    
    PARITY_CHECKER #(.WIDTH(WIDTH)) PCHECKER(.clk(clk), .rst(rst), .RX_data(RX_data), .parity_load(parity_load_wire), 
                                                        .data(d2p), .parity_bit_err(parity_bit_err), .data_out(p2s));
                                                        
    STOP_CHECKER #(.WIDTH(WIDTH)) SCHECKER(.clk(clk), .rst(rst), .RX_data(RX_data), .check_stop(check_stop_wire), .data(p2s),
                                                .stop_bit_err(stop_bit_err), .data_out(RX_data_out));
endmodule
