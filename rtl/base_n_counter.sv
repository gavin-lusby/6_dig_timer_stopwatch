`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 09:37:06 AM
// Design Name: 
// Module Name: base_n_counter
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


module base_n_counter #(
    parameter int BASE
) (
        input logic clk,
        input logic rst,
        input logic ena,
        output logic [COUNTER_WIDTH-1:0]count_out,
        output logic ena_next
    );
    
    localparam int COUNTER_WIDTH = $clog2(BASE);
    logic rst_state;
    
    always_ff @(posedge clk)
    begin
        if(rst == 1)
        begin
            count_out <= 0;
            ena_next <= 0;
            rst_state <= 1;
        end
        else if (rst_state == 1)
        begin
            count_out <= 0;
            ena_next <= 0;
            rst_state <= 0;
        end
        else if (ena == 1)
        begin
            if (count_out == (BASE - 1))
            begin
                count_out <= 0;
                ena_next <= 0;
            end
            else
            begin
                count_out <= count_out + 1;
                if(count_out == (BASE - 2))
                begin
                    ena_next <= 1;
                end
            end
        end
    end
endmodule
