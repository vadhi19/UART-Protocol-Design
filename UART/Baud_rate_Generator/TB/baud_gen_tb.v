`timescale 1ns / 1ps

`define CLOCKFREQ 96e6
`define BAUDRATE 9600

`define CLOCKPERIOD (1e9/`CLOCKFREQ) 
`define HALFCLOCK (`CLOCKPERIOD/2)
`define BAUDREG (`CLOCKFREQ/`BAUDRATE)

module baud_gen_tb();

reg clk;
reg rst;
reg [15:0]wait_clock;

wire bclk;

BAUD_GEN BAUD(.clk(clk), .rst(rst), .wait_clock(wait_clock), .bclk(bclk));

initial
    begin
        clk = 1'b0;
        forever #(`HALFCLOCK)clk = ~clk;
    end

task reset();
begin
    @(posedge clk);
    rst = 1'b0;
    @(posedge clk);
    rst = 1'b1;
end
endtask

initial
    begin
        reset;
        wait_clock = `BAUDREG;
        #50000 $finish;
    end
    
endmodule
