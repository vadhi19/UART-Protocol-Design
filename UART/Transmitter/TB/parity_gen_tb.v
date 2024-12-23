`timescale 1ns / 1ps

module parity_gen_tb #(parameter WIDTH = 8)();

reg clk, rst;
reg load_bit;
reg [WIDTH-1 : 0]data;
wire p_out;

Parity_gen #(.WIDTH(WIDTH)) P1(.clk(clk), .rst(rst), .load_bit(load_bit), .data(data), .p_out(p_out));

initial 
    begin
        clk = 1'b0;
        forever #5 clk = !clk;
    end

task reset();
begin
    @(posedge clk);
    rst = 1'b0;
    @(posedge clk)
    rst = 1'b1;
end
endtask

initial
    begin
        reset;
        load_bit = 1'b1;
        data = 8'b11101001;
        #10;
        load_bit <= 1'b0;
    end
endmodule
