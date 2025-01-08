`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2024 04:23:04 PM
// Design Name: 
// Module Name: pwm_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm_generator #(
    parameter int PRESCALER,
    parameter int PULSE_WIDTH,
    parameter int OFFSET
) (
        input logic clk,
        input logic rst,
        input logic ena,
        output logic pulse_out
    );
    
    localparam int counter_width = $clog2(PRESCALER);
    logic [(counter_width-1):0]counter = '0;
    logic rst_state;
    
    generate
        if (PULSE_WIDTH < 1)
        begin
            $error("Pulse Width cannot be less than 1");
        end
        else if (OFFSET < 0)
        begin
            $error("Offset cannot be less than 0");
        end
        else if (PULSE_WIDTH + OFFSET > PRESCALER)
        begin
            $error("Pulse Width + Offset must be less than Prescaler value");
        end
    endgenerate

    always_ff @(posedge clk)
    begin
        if(rst == 1)
        begin
            rst_state <= 1;
        end
        else if ((ena == 1) && (rst_state == 1))
        begin
            rst_state <= 0;
        end
    end


    generate
        if(OFFSET > 0)
        begin : PWM_WITH_OFFSET
            always_ff @(posedge clk)
            begin
                if(rst == 1)
                begin
                    counter <= '0;
                    pulse_out <= 0;
                end
                else if (ena == 1)
                begin
                    if ((counter == (PRESCALER - 1)) || (rst_state == 1))
                    begin
                        counter <= '0;
                        pulse_out <= 0;
                    end
                    else
                    begin
                        counter <= counter + 1;
                        if(counter == OFFSET - 1)
                        begin
                            pulse_out <= 1;
                        end
                        else if(counter == OFFSET + PULSE_WIDTH - 1)
                        begin
                            pulse_out <= 0;
                        end
                    end
                end
            end
        end : PWM_WITH_OFFSET
        else
        begin : PWM_WITHOUT_OFFSET
            always_ff @(posedge clk)
            begin
                if(rst == 1)
                begin
                    counter <= '0;
                    pulse_out <= 0;
                end
                else if (ena == 1)
                begin
                    if ((counter == (PRESCALER - 1)) || (rst_state == 1))
                    begin
                        counter <= '0;
                        pulse_out <= 1;
                    end
                    else
                    begin
                        counter <= counter + 1;
                        if(counter == PULSE_WIDTH - 1)
                        begin
                            pulse_out <= 0;
                        end
                    end
                end
            end
        end : PWM_WITHOUT_OFFSET
    endgenerate
    
    
    
    
endmodule
