# UART-Protocol-Design

This repository contains the design and implementation of a Universal Asynchronous Receiver/Transmitter (UART) protocol using hardware description languages like Verilog and SystemVerilog. The UART protocol is widely used for serial communication between devices due to its simplicity and reliability.

Key features of UART include:

* Start and Stop Bits: Define the beginning and end of a data packet.
* Parity Bit (optional): Provides simple error detection.
* Data Bits: Typically 8 bits of actual data per packet.
* Baud Rate: Determines the speed of data transmission, commonly set at 9600 bps, 115200 bps, etc.

Project Contents

1. Design Files:
    * Verilog-based implementation of UART Transmitter and Receiver.
    * Parameterized modules for easy configuration of baud rate, data width, and stop bits.

2. Testbenches:
    * Verilog testbenches to verify the functionality of the transmitter and receiver.

3. Simulation Results:
    * Timing diagrams showcasing data transmission and reception.

![image](https://github.com/user-attachments/assets/dd0799ce-4040-4479-99e4-e7c1a12e6da9)
