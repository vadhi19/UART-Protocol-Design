`timescale 1ns / 1ps

module mux_4x1_tb();

reg [1:0] sel;
reg in0, in1, in2, in3;
wire data_out;

Mux_4x1 M1(.sel(sel), .in0(in0), .in1(in1), .in2(in2), .in3(in3), .data_out(data_out));

initial 
    begin
        in0 = 1'b1;
        sel = 2'b00;
    end
endmodule
