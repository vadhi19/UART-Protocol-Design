`timescale 1ns/1ps

module RX_FSM(input start_bit_detect,
                input clk, rst,
                input parity_bit_err,
                output reg parity_load,
                output reg shift_bit,
                output reg check_stop);
                
    parameter IDLE = 2'b00,
              DATA = 2'b01,
              PARITY = 2'b10,
              STOP = 2'b11,
              WIDTH = 4'd8;
                
    reg [1:0] state, next_state;
    
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
            next_state = state;
            case(state)
                
                IDLE : begin
                            if(start_bit_detect)
                                next_state = DATA;
                            else
                                next_state = IDLE;
                       end
                     
                DATA : begin
                            if(count < WIDTH - 1'b1)
                                begin
                                    next_state = DATA;
                                end
                            else
                                begin
                                    next_state = PARITY;
                                end 
                       end
                       
                PARITY : begin
                            if(!parity_bit_err)  
                                next_state = STOP;
                            else
                                next_state = IDLE;
                          end
                
                STOP : next_state = IDLE;
                
                default : next_state = IDLE;
                
            endcase
        end
        
        always@(posedge clk or negedge rst)
            begin
                 if(!rst)
                    begin
                        parity_load <= 1'b0;
                        check_stop <= 1'b0;
                        shift_bit <= 1'b0;
                        
                    end   
                    
                 else
                    begin
                    
                        parity_load <= 1'b0;
                        check_stop <= 1'b0;
                        shift_bit <= 1'b0;
                        count <= 3'b0;
                       
                        
                        case(state)
                            
                            IDLE : begin
                                        parity_load <= 1'b0;
                                        check_stop <= 1'b0;
                                        shift_bit <= 1'b0;
                                   end
                                   
                            DATA : begin
                                       
                                        count <= count + 1'b1;
                                        shift_bit <= 1'b1; 
                                        
                                   end
                                   
                            PARITY : begin
                                        shift_bit <= 1'b1;
                                        parity_load <= 1'b1;
                                        check_stop <= 1'b0;
                                         
                                     end
                                     
                            STOP : begin
                                        shift_bit <= 1'b0;
                                        check_stop <= 1'b1;
                                        parity_load <= 1'b0;
                                        
                                   end
                                   
                             default : begin
                                            parity_load <= 1'b0;
                                            check_stop <= 1'b0;
                                            shift_bit <= 1'b0;
                             
                                       end
                        endcase
                    end
            end
endmodule
