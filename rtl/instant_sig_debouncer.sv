`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2024 06:04:02 PM
// Design Name: 
// Module Name: instant_sig_debouncer
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


module instant_sig_debouncer #(
    parameter int DEBOUNCE_CYCLES
) (
    input logic clk,
    input logic rst,
    input logic ena,
    input logic sig_in,
    output logic sig_debounced = 0
    );
    
    localparam int counter_width = $clog2(DEBOUNCE_CYCLES);
    logic [(counter_width-1):0]counter = '0;
    logic state_frozen;
    always_ff @(posedge clk)
    begin
        if(rst == 1)
        begin
            sig_debounced <= 0;
            state_frozen <= 0;
            counter <= '0;
        end
        else if(ena == 1)
        begin
            if (!state_frozen)
            begin
                if(sig_debounced != sig_in)
                begin
                    sig_debounced <= ~sig_debounced;
                    state_frozen <= 1;
                    counter <= counter + 1;
                end
            end
            else
            begin
                if(counter < DEBOUNCE_CYCLES - 1)
                begin
                    counter <= counter + 1;
                end
                else
                begin
                    state_frozen <= 0;
                    counter <= '0;
                end
            end
            
        end
        
    end
    
endmodule
