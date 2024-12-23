`timescale 1ns / 1ps

module PISO_tb #(parameter WIDTH = 8)();

reg clk, rst;
reg [ WIDTH - 1 : 0]data;
reg load_bit, shift_bit;
wire data_out;

PISO #(.WIDTH(WIDTH)) P1(.clk(clk), .rst(rst), .data(data), .load_bit(load_bit), .shift_bit(shift_bit), .data_out(data_out));

task initialize;
    data = 0;
endtask

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

task inputs(input [WIDTH - 1 : 0] da);
    begin
        @(negedge clk);
        data = da;
    end
endtask

initial
    begin
        initialize;
        reset;
        load_bit = 1'b1;
        inputs(8'b10101101);
        #10;
        load_bit = 1'b0;
        
        #10;
        shift_bit = 1'b1;
        
        #100;
        shift_bit = 1'b0;
    end

initial
    #1000 $finish;
endmodule
