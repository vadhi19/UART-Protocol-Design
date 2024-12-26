`timescale 1ns/1ps

module SIPO_tb #(parameter WIDTH = 8)();

reg clk,rst;
reg RX_data;
reg shift_bit;
wire [WIDTH - 1 : 0] data_out;

SIPO #(.WIDTH(WIDTH)) S1(.clk(clk), .rst(rst), .RX_data(RX_data), .shift_bit(shift_bit), .data_out(data_out));

initial
    begin
        clk = 1'b0;
        forever #5 clk = !clk;
    end
    
task reset;
    begin
        @(posedge clk);
        rst = 1'b0;
        @(posedge clk);
        rst = 1'b1;
    end
endtask

task shift(input s);
    begin
        @(negedge clk);
        shift_bit = s;
    end
endtask

task inputs(input data);
    begin
        @(negedge clk);
        RX_data = data;
    end
endtask

initial
    begin
        reset;
        shift(1'b1);
        inputs(1'b1);
        inputs(1'b1);
        inputs(1'b0);
        inputs(1'b1);
        inputs(1'b0);
        inputs(1'b1);
        inputs(1'b1);
        inputs(1'b1);
        shift(1'b0);
    end
endmodule
