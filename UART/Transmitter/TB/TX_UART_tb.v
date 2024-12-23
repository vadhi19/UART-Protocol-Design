`timescale 1ns / 1ps

module TX_UART_TB #(parameter WIDTH = 8)();

reg clk, rst;
reg start;
reg [WIDTH - 1 : 0]data;
wire data_out;
wire busy;

UART_TX #(.WIDTH(WIDTH)) DUT(.clk(clk), .rst(rst),.start(start), .data(data), .data_out(data_out), .busy(busy));

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

task start_pin;
    begin
        @(posedge clk);
        start = 1'b0;
        @(posedge clk);
        start = 1'b1;
    end
endtask

initial
    begin
        reset;
        start_pin;
        data = 8'b01001100;
    end
endmodule
