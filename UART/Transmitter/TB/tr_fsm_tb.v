`timescale 1ns / 1ps

module tr_fsm_tb#(parameter WIDTH = 8)();

reg rst, clk;
reg start;
wire shift_bit, load_bit;
wire start_bit, stop_bit;
wire [1:0]sel;
wire busy;

trans_fsm #(.WIDTH(WIDTH)) FSM(.rst(rst), .clk(clk), .start(start), .shift_bit(shift_bit), .load_bit(load_bit),
                                    .start_bit(start_bit), .stop_bit(stop_bit), .sel(sel), .busy(busy));
                                    
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
    
    task start_pin();
        begin
            @(negedge clk);
            start = 1'b0;
            @(negedge clk);
            start = 1'b1;
        end
    endtask
    
    initial
        begin
            reset;
            start_pin;
        end
endmodule
