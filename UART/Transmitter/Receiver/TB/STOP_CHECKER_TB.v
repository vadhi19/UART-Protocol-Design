`timescale 1ns / 1ps

module STOP_CHECKER_TB #(parameter WIDTH = 8)();

reg clk, rst;
reg check_stop;
reg RX_data;
wire stop_bit_err;

STOP_CHECKER #(.WIDTH(WIDTH)) S1(.clk(clk), .rst(rst), .check_stop(check_stop), 
                                  .RX_data(RX_data), .stop_bit_err(stop_bit_err));
                                    
    initial
        begin
            clk = 1'b0;
            forever #5 clk = !clk;
        end 
        
     task initialize;
        
     endtask
        
     task reset;
        begin
            @(negedge clk);
            rst = 1'b0;
            @(negedge clk);
            rst = 1'b1;
        end
     endtask
     
     task inputs(input data);
        begin
            @(negedge clk);
            RX_data = data;
        end
     endtask
     
     task check();
        begin
            @(negedge clk);
            check_stop = 1'b1;
            @(negedge clk);
            check_stop = 1'b0;
        end
     endtask
     
     initial
        begin
            reset;
            inputs(1'b0);
            check;
        end
endmodule
