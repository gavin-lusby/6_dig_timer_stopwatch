`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 11:46:38 AM
// Design Name: 
// Module Name: timer_integration
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


module timer_integration #(
        parameter int NUM_DIGITS = 6
) (
        input logic g_clk,
        input logic g_rst,
        input logic button_2, /* Play/pause/reset: decrease precision, config: cycle which digit selected */
        input logic button_3, /* Play/pause/reset: increase precision, config: cycle selected digit's value */
        output logic all_nrst,
        output logic control_reg_clk,
        output logic all_bit_clk,
        output logic control_data_ser,
        output logic digit_data_ser
    );


    //---------------------------------------------
    //---------------------------------------------
    //TEMP -=- BASE N COUNTERS START
    //---------------------------------------------
    //---------------------------------------------
//    logic counter_inc_ena;
//    pwm_generator #(
//        .PRESCALER(100000),
//        .PULSE_WIDTH(1),
//        .OFFSET(0)
//    ) counter_inc_enabler (
//        .clk(g_clk),
//        .rst(g_rst),
//        .ena(1'b1),
//        .pulse_out(counter_inc_ena)
//    );
//    logic [NUM_DIGITS-1:0]dig_count_ena_next_in;
//    logic [NUM_DIGITS-1:0]dig_count_ena_next_out;
//    assign dig_count_ena_next_in[0] = counter_inc_ena;
//    logic [NUM_DIGITS-1:0][3:0] dig_datas;
//    logic [NUM_DIGITS-1:0][7:0] dig_datas_7seg;
//    base_n_counter # (
//        .BASE(10)
//    ) base_10_counter_0 (
//        .clk(g_clk),
//        .rst(g_rst),
//        .ena(dig_count_ena_next_in[0]),
//        .count_out(dig_datas[0]),
//        .ena_next(dig_count_ena_next_out[0])
//    );
    
//    genvar k;
//    generate
//        for(k = 1; k < NUM_DIGITS; k++)
//        begin
//           assign dig_count_ena_next_in[k] = (dig_count_ena_next_in[k-1] & dig_count_ena_next_out[k-1]);
//           base_n_counter # (
//                .BASE(10)
//            ) base_10_counter_0 (
//                .clk(g_clk),
//                .rst(g_rst),
//                .ena(dig_count_ena_next_in[k]),
//                .count_out(dig_datas[k]),
//                .ena_next(dig_count_ena_next_out[k])
//            );
//        end
//    endgenerate
    
//    generate
//        for(k = 0; k < NUM_DIGITS; k++)
//        begin
//           dig_to_seven_seg seven_seg_conv(
//                .dig_in(dig_datas[k]),
//                .dec_on(decimals_out[k]),
//                .seven_seg_out(dig_datas_7seg[k])
//            );
//        end
//    endgenerate

    
    //---------------------------------------------
    //---------------------------------------------
    //TEMP -=- BASE N COUNTERS END
    //---------------------------------------------
    //---------------------------------------------

    //---------------------------------------------
    //---------------------------------------------
    //TEMP2 -=- DIG & DEC SHOW OFF START
    //---------------------------------------------
    //---------------------------------------------

    logic [NUM_DIGITS-1:0][7:0] dig_datas_7seg;

    total_digit_drawer # (
        .IN_SIZE(17),
        .OUT_SIZE(NUM_DIGITS),
        .CHANGE_ON_RISING(1),
        .DEFAULT_SHIFT_STATE(9)
    ) dig_drawer_module (
        .clk(g_clk),
        .ena(1'b1),
        .rst(g_rst),
        .in_digits(68'h123456789ABCDEF05),
        .in_dps(17'b01010101000000000),
        .shift_up(button_2),
        .shift_down(button_3),
        .out_7seg_display(dig_datas_7seg)
        );
    //---------------------------------------------
    //---------------------------------------------
    //TEMP2 -=- DIG & DEC SHOW OFF END
    //---------------------------------------------
    //---------------------------------------------

    hw_registers_controller # (
        .REG_SIZE(8),
        .NUM_DATA_REG(NUM_DIGITS),
        .CYCLES_PER_UPDATE(100),
        .CLK_PRESCALER(1000)
    ) hw_reg_interface (
        .clk(g_clk),
        .rst(g_rst),
        .ena(1'b1),
        .dig_data_in(~dig_datas_7seg),
        .all_bit_clk(all_bit_clk),
        .all_nrst(all_nrst),
        .control_data_ser(control_data_ser),
        .control_reg_clk(control_reg_clk),
        .digit_data_ser(digit_data_ser)
    );
endmodule
