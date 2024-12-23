`timescale 1ns / 1ps

module trans_fsm #(parameter WIDTH = 8)(input start,
                input clk, rst,
                output reg start_bit,
                output reg stop_bit,
                output reg shift_bit,
                output reg load_bit,
                output reg busy,
                output reg [1:0]sel);
                
    reg [2:0] state, next_state;
    
    localparam IDLE   = 3'b000,
               START  = 3'b001,
               DATA   = 3'b010,
               PARITY = 3'b011,
               STOP   = 3'b100;
    
    reg [2:0]count;
    
    always@(posedge clk or negedge rst)
        begin
            if(!rst)
                state <= IDLE;
            else
                state <= next_state;
        end
        
    always@(*)
        begin
        next_state <= state;
            case(state)
                IDLE : begin 
                            if(!start)
                                next_state <= IDLE;
                            else
                                next_state <= START;
                        end
                        
                START : next_state <= DATA;
                
                DATA : begin 
                            if(count != WIDTH - 1'b1)
                                next_state <= DATA;
                            else
                                next_state <= PARITY;       
                       end
                       
                PARITY : next_state <= STOP;
                
                STOP : next_state <= IDLE;
                
                default : next_state <= IDLE;
                
             endcase
        end
        
        always@(posedge clk or negedge rst)
            begin
                if(!rst)
                    begin
                        count <= 3'b000;
                        start_bit <= 1'b0;
                        stop_bit <= 1'b0;
                        load_bit <= 1'b0;
                        shift_bit <= 1'b0;
                        busy <= 1'b0;
                        sel <= 2'b00;
                    end
                    
                else
                    begin
                        count <= 3'b000;
                        start_bit <= 1'b0;
                        stop_bit <= 1'b0;
                        load_bit <= 1'b1;
                        shift_bit <= 1'b0;
                        busy <= 1'b0;
                        sel <= 2'b00;
                        case(state)
                            
                            IDLE : begin
                                        busy <= 1'b0;
                                    end
                                    
                            START : begin
                                        start_bit <= 1'b0;
                                        load_bit <= 1'b1;
                                        busy <= 1'b1;
                                        sel <= 2'b00;
                                    end
                                    
                            DATA : begin 
                                        load_bit <= 1'b0;                                              
                                        count <= count + 1'b1;
                                        busy <= 1'b1;
                                        sel <= 2'b01;
                                        shift_bit <= 1'b1;
                                   end
                                   
                            PARITY : begin
                                        shift_bit <= 1'b0;
                                        busy <= 1'b1;
                                        sel <= 2'b10;
                                     end
                                     
                            STOP : begin
                                        stop_bit <= 1'b1;
                                        busy <= 1'b1;
                                        sel <= 2'b11;
                                    end
                                    
                            default : begin
                                            load_bit <= 1'b1;
                                            shift_bit <= 1'b0;
                                            busy <= 1'b0;
                                            sel <= 2'b00;
                                        end
                        endcase
                    end
            end
endmodule
 