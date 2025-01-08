`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 06:54:26 PM
// Design Name: 
// Module Name: sig_debouncer
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


module sig_debouncer #(
    parameter int DEBOUNCE_CYCLES
) (
    input logic clk,
    input logic rst,
    input logic ena,
    input logic sig_in,
    output logic sig_debounced = 0
    );
    
    localparam int counter_width = $clog2(DEBOUNCE_CYCLES+1);
    logic [(counter_width-1):0]counter = '0;
    
    always_ff @(posedge clk)
    begin
        if(rst == 1)
        begin
            sig_debounced <= 0;
            counter <= '0;
        end
        else if(ena == 1)
        begin
            if(counter == DEBOUNCE_CYCLES)
            begin
                sig_debounced <= ~sig_debounced;
                counter <= '0;
            end
            else if (sig_debounced == sig_in)
            begin
                counter <= '0;
            end
            else
            begin
                counter <= counter + 1;
            end
        end
        
    end
    
endmodule
