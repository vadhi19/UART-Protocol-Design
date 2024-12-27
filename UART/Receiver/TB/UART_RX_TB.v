`timescale 1ns / 1ps

module UART_RX_TB #(parameter WIDTH = 8)();

reg clk, rst;
reg RX_data;
wire parity_bit_err;
wire stop_bit_err;
wire [WIDTH - 1 : 0]RX_data_out;

UART_RX #(.WIDTH(WIDTH)) RX(.clk(clk), .rst(rst), .RX_data(RX_data), .parity_bit_err(parity_bit_err), .stop_bit_err(stop_bit_err), 
                                                    .RX_data_out(RX_data_out));
                                                    
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
    
    task inputs(input d);
        begin
            @(negedge clk);
            RX_data = d;
        end
    endtask
    
    initial
        begin
            RX_data = 1'b0;
            reset;
            inputs(1'b0); //start bit
            
            inputs(1'b0); // data bits
            inputs(1'b1);
            inputs(1'b1);
            inputs(1'b0);
            inputs(1'b1);
            inputs(1'b0);
            inputs(1'b1);
            inputs(1'b1);
            
            inputs(1'b1); //parity_bit
            
            inputs(1'b1); //stop bit
            
            #200$finish;
         end  
endmodule
