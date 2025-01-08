`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 10:25:58 AM
// Design Name: 
// Module Name: total_digit_drawer
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


module total_digit_drawer # (
    parameter int IN_SIZE=17, /* Number of digits to input */
    parameter int OUT_SIZE=6, /* Number of digits to output, must be atleast 2 */
    parameter int CHANGE_ON_RISING=1, /* Determine of digits shift on rising/falling edge of shift up/down signals */
    parameter int DEFAULT_SHIFT_STATE=9 /* Default amount of digits to be shifted right by */
) (
    input logic clk,
    input logic ena,
    input logic rst,
    input logic [IN_SIZE-1:0][3:0]in_digits,
    input logic [IN_SIZE-1:0]in_dps, /* Decimal Points */
    input logic shift_up,
    input logic shift_down,
    output logic [OUT_SIZE-1:0][7:0]out_7seg_display
    );

    localparam int SHIFT_AMT_SIZE = $clog2(IN_SIZE - OUT_SIZE + 1);
    
    logic [SHIFT_AMT_SIZE-1:0]shift_amount;
    logic [OUT_SIZE-1:0][3:0]digits_to_display;
    logic [OUT_SIZE-1:0]dps_to_display;
    logic [SHIFT_AMT_SIZE-1:0]dp_shift_amount;
    assign dp_shift_amount = shift_amount+1;
    assign dps_to_display[0] = 1'b0; /* Bottom decimal points not needed because it should always be off */

    value_shifter # (
        .NUM_SHIFT_STATES(IN_SIZE - OUT_SIZE + 1),
        .DEFAULT_SHIFT_STATE(9),
        .CHANGE_ON_RISING(1)
    ) shift_amount_producer (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .shift_amount(shift_amount)
    );


    digit_selector #(
        .IN_SIZE(IN_SIZE),
        .OUT_SIZE(OUT_SIZE),
        .DIG_WIDTH(4)
    ) dig_select_module (
        .in_digits(in_digits),
        .shift_amount(shift_amount),
        .out_digits(digits_to_display)
    );

    digit_selector #(
        .IN_SIZE(IN_SIZE),
        .OUT_SIZE(OUT_SIZE - 1),
        .DIG_WIDTH(1)
    ) dp_select_module (
        .in_digits(in_dps),
        .shift_amount(dp_shift_amount),
        .out_digits(dps_to_display[OUT_SIZE - 1:1])
    );

    genvar i;
    generate
        for(i = 0; i < OUT_SIZE; i++)
        begin
            dig_to_seven_seg seven_seg_conv(
                .dig_in(digits_to_display[i]),
                .dec_on(dps_to_display[i]),
                .seven_seg_out(out_7seg_display[i])
            );
        end
    endgenerate
    
endmodule
