`timescale 1ns / 1ps

module RX_FSM_TB();

reg clk, rst;
reg start_bit_detect;
reg parity_bit_err;
wire parity_load;
wire shift_bit;
wire check_stop;

RX_FSM F1(.clk(clk), .rst(rst), .start_bit_detect(start_bit_detect), .parity_bit_err(parity_bit_err), 
                    .parity_load(parity_load), .shift_bit(shift_bit), .check_stop(check_stop));
                    
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
    
    task parity(input p);
        begin
            @(negedge clk);
            parity_bit_err = p;
        end
    endtask
    
    task start;
        begin
            @(negedge clk);
            start_bit_detect = 1'b0;
            @(negedge clk);
            start_bit_detect = 1'b1;
        end
    endtask
    
    initial
        begin
            reset;
            start;
            parity(1'b0);
        end
endmodule
