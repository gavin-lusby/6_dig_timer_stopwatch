`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2024 02:04:49 PM
// Design Name: 
// Module Name: tb_total_digit_drawer
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


module tb_total_digit_drawer;

    localparam int NUM_DIGITS = 6;

    logic clk;
    logic rst;
    logic ena;
    logic [67:0]in_digits;
    logic [16:0]in_dps;
    logic shift_up;
    logic shift_down;
    logic [NUM_DIGITS-1:0][7:0]out_7seg;
    logic [NUM_DIGITS-1:0][3:0]out_7seg_num;
    logic [NUM_DIGITS-1:0]out_decimal;
    logic [NUM_DIGITS-1:0]out_invalid;

    assign in_digits = 68'h123456789ABCDEF05;
    assign in_dps = 17'b01010101000000000;

    initial
    begin
        clk = 0;
        forever #0.5 clk = ~clk;
    end
    
    initial
    begin
        rst = 1;
        ena = 0;
        shift_up = 0;
        shift_down = 0;
        #10
        ena = 1;
        rst = 0;
        #10
        for(int i = 0; i < 20; i++)
        begin
            shift_up = 1;
            #5
            shift_up = 0;
            #5;
        end
        for(int i = 0; i < 20; i++)
        begin
            shift_down = 1;
            #5
            shift_down = 0;
            #5;
        end
    end

    total_digit_drawer # (
        .IN_SIZE(17),
        .OUT_SIZE(NUM_DIGITS),
        .CHANGE_ON_RISING(1),
        .DEFAULT_SHIFT_STATE(9)
    ) dig_drawer_module (
        .clk(clk),
        .ena(ena),
        .rst(rst),
        .in_digits(in_digits),
        .in_dps(in_dps),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .out_7seg_display(out_7seg)
        );

    genvar i;
    generate
        for(i = 0; i < NUM_DIGITS; i++)
        begin
            seven_seg_reader dig_verif(
                .seven_seg_in(out_7seg[i]),
                .dig_out(out_7seg_num[i]),
                .dec_on(out_decimal[i]),
                .invalid(out_invalid[i])
            );
        end
    endgenerate
endmodule
