`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 11:02:44 AM
// Design Name: 
// Module Name: value_shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      Increments/Decrements shift_amount by 1 within the range of
//      0 and NUM_SHIFT_STATES once per rising/falling edge of
//      shift_up and shift_down signal respectively
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module value_shifter # (
    parameter int NUM_SHIFT_STATES=12,
    parameter int DEFAULT_SHIFT_STATE=9,
    parameter int CHANGE_ON_RISING=1
) (
    input logic clk,
    input logic rst,
    input logic ena,
    input logic shift_up,
    input logic shift_down,
    output logic [SHIFT_AMT_SIZE-1:0]shift_amount
    );

    localparam int SHIFT_AMT_SIZE = $clog2(NUM_SHIFT_STATES);
    logic shift_up_prev;
    logic shift_down_prev;
    logic shift_up_edge;
    logic shift_down_edge;

    generate
        if(CHANGE_ON_RISING)
        begin
            assign shift_up_edge = (~shift_up_prev) & shift_up;
            assign shift_down_edge = (~shift_down_prev) & shift_down;
        end
        else
        begin
            assign shift_up_edge = shift_up_prev & (~shift_up);
            assign shift_down_edge = shift_down_prev & (~shift_down);
        end
    endgenerate


    always_ff @(posedge clk)
    begin
        if(rst == 1)
        begin
            shift_amount <= DEFAULT_SHIFT_STATE;
        end
        else if (ena == 1)
        begin
            shift_up_prev <= shift_up;
            shift_down_prev <= shift_down;
            if((shift_up_edge) && (~shift_down_edge) && (shift_amount < NUM_SHIFT_STATES - 1))
            begin
                shift_amount += 1;
            end
            else if((shift_down_edge) && (~shift_up_edge) && (shift_amount > 0))
            begin
                shift_amount -= 1;
            end
        end
    end
endmodule
