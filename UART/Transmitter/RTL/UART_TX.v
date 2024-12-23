`timescale 1ns / 1ps

module UART_TX #(parameter WIDTH = 8)(input clk, rst,
                                      input start,
                                      input [WIDTH - 1 : 0]data,
                                      output data_out,
                                      output busy);
    
    wire shift_wire, load_wire;
    wire start_bit_wire, stop_bit_wire;
    wire [1:0] sel_wire;
    wire parity_out_wire;
    wire data_out_wire;
       
    trans_fsm #(.WIDTH(WIDTH)) TX_FSM(.start(start), .clk(clk), .rst(rst), .shift_bit(shift_wire), .start_bit(start_bit_wire), .stop_bit(stop_bit_wire),
                                      .load_bit(load_wire), .sel(sel_wire), .busy(busy));
    
    PISO #(.WIDTH(WIDTH)) TX_PISO(.clk(clk), .rst(rst), .data(data), .shift_bit(shift_wire), .load_bit(load_wire), .data_out(data_out_wire)); 
    
    Parity_gen #(.WIDTH(WIDTH)) TX_PARITY_GEN(.clk(clk), .rst(rst), .data(data), .load_bit(load_wire), .p_out(parity_out_wire));
    
    Mux_4x1 TX_MUX(.sel(sel_wire), .in0(start_bit_wire), .in1(data_out_wire), .in2(parity_out_wire), 
                   .in3(stop_bit_wire), .data_out(data_out));
endmodule
