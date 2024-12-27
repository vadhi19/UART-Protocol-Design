# UART-Protocol-Design

UART Protocol Documentation

Overview :
  *  The Universal Asynchronous Receiver/Transmitter (UART) protocol is a widely used serial communication protocol for low-cost, low-speed data exchange between devices. It is        particularly popular in embedded systems and microcontrollers, providing a straightforward way to interface peripherals with minimal hardware requirements.

  *  UART operates using two main wires for communication: TX (Transmit) and RX (Receive). It does not require a clock signal, making it an asynchronous protocol.
  *  HDL : Verilog 
  *  TOOL: Xilinx Vivado 2023.1

![pindiagram](https://github.com/user-attachments/assets/603ab0e0-2d97-4c39-86b3-6f88986acd50)

Key Features of UART:

1. Asynchronous Communication: Data is transmitted without a shared clock signal. Instead, both devices agree on a common baud rate.
2. Simple Hardware Interface: Requires only two data lines (TX and RX) for bi-directional communication.
3. Configurable Parameters:
    *  Baud rate (e.g., 9600, 115200 bps)
    *  Data bits (typically 8 bits)
    *  Parity (even or odd)
    *  Stop bits (1 or 2) 
4. Error Detection: Optional parity bits and framing checks help detect errors in communication.

How UART Works:

1. Data Transmission
   UART converts parallel data into a serial stream for transmission. The data frame typically consists of:
   *  Start Bit: Indicates the beginning of data transmission.
   * Data Bits: 5 to 9 bits of actual data.
   * Parity Bit: Optional error-checking bit.
   * Stop Bit(s): Marks the end of the transmission.

2. Data Reception:
    *  The receiving device monitors the RX line for a start bit, then samples the incoming data bits at the agreed baud rate. After reconstructing the frame, it checks for errors and processes the data.
    *  Start Bit: A low signal (0) for one bit duration.
    *  Data Bits: Sequential bits of the data byte.
    *  Stop Bit: A high signal (1) for one bit duration.
  
![image](https://github.com/user-attachments/assets/dd0799ce-4040-4479-99e4-e7c1a12e6da9)

Limitations:
  *  Limited distance (typically a few meters).
  *  No built-in support for addressing or device selection.
  *  Slower compared to other serial protocols like SPI and I2C.
    
Resources and References:
  *  https://www.geeksforgeeks.org/universal-asynchronous-receiver-transmitter-uart-protocol/
  *  https://docs.arduino.cc/learn/communication/uart/
  *  https://www.chipverify.com/tutorials/verilog
