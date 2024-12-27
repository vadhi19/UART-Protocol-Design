`timescale 1ns / 1ps

module detect_start(
    input RX_data,
    output start_bit_detect
);
    assign start_bit_detect = !RX_data; // Start bit is 0
endmodule