`timescale 100ns / 1ps

`define CLOCK_FREQ 48e6
`define BAUDRATE 9600

`define CLOCKPERIOD (1e9/`CLOCK_FREQ)
`define WAITCLOCK (`CLOCK_FREQ/`BAUDRATE)
`define HALFCLOCK (`CLOCKPERIOD/2)

module UART_TB #(parameter WIDTH  = 8)();

reg clk, rst;
reg start;
reg [15:0]wait_clock;
reg [WIDTH - 1 : 0]TX_data_in;
wire busy;
wire stop_bit_err;
wire parity_bit_err;
wire [WIDTH - 1 : 0]RX_data_out;

UART_TOP #(.WIDTH(WIDTH)) DUT(.clk(clk), .rst(rst), .start(start), .TX_data_in(TX_data_in), .busy(busy), .stop_bit_err(stop_bit_err), 
                                 .wait_clock(wait_clock), .parity_bit_err(parity_bit_err), .RX_data_out(RX_data_out));
                                
    initial
        begin
            clk = 1'b0;
            forever #(`HALFCLOCK) clk = ~clk;
        end
        
        
    task reset;
        begin
            @(posedge clk);
            rst = 1'b0;
            @(negedge clk);
            rst = 1'b1;
        end
    endtask
    
    task start_pin(input s);
        begin
            @(negedge clk);
            start = s;
        end
    endtask
        
     task inputs(input [WIDTH - 1 : 0]data);
        begin
            @(negedge clk);
            TX_data_in = data;
        end
     endtask
     
     initial
        begin
            wait_clock = `WAITCLOCK;
        end 
     
     initial
        begin
            reset;
            start_pin(1'b1);
            inputs(8'b11010011);
            #1000000;
            start_pin(1'b0);
            #1000 $stop;
        end
endmodule
