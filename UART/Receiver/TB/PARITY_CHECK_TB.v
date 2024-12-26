`timescale 1ns / 1ps

module PARITY_CHECK_TB #(WIDTH = 8)();

reg clk, rst;
reg [WIDTH - 1 : 0]data;
reg RX_data;
reg parity_load;
wire parity_bit_err;

PARITY_CHECKER #(.WIDTH(WIDTH)) P1(.clk(clk), .rst(rst), .data(data), .RX_data(RX_data), 
                                        .parity_load(parity_load), .parity_bit_err(parity_bit_err));
                                        
    task initialize;
        {data,RX_data} = 0;
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
    
    
    task parity_data(input data);
        begin
            @(negedge clk);
            parity_load = 1'b1;
            RX_data = data;
            @(negedge clk);
            parity_load = 1'b0;
        end
    endtask
    
    initial
        begin
            initialize;
            reset;
            parity_data(1'b1);
            data = 8'b11001111;
        end
endmodule
