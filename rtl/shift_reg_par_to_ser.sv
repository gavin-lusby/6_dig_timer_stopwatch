`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 10:22:13 PM
// Design Name: 
// Module Name: shift_reg_par_to_ser
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


module shift_reg_par_to_ser #(
    parameter int WIDTH=8
) (
        input logic clk,
        input logic rst,
        input logic ena,
        input logic write,
        input logic [WIDTH-1:0]data_in,
        output logic data_out
    );
    
    logic [WIDTH-1:0]shift_reg;
    assign data_out = shift_reg[0];
    always_ff @(posedge clk)
    begin
        if (rst == 1)
        begin
            shift_reg <= 8'b0;
        end
        else
        begin
            if (ena == 1)
            begin
                if (write == 1)
                begin
                    shift_reg <= data_in;
                end
                else
                begin
                    shift_reg <= {1'b0, shift_reg[WIDTH-1:1]};
                end
            end
        end
    end
endmodule
