`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 06:14:36 PM
// Design Name: 
// Module Name: toplevel
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
`define MIN_INPUT_HOLD_CYCLES 20_000 /* 0.2ms at 100MHz */


module toplevel # (
    parameter int NUM_PUSHBUTTONS = 4,
    parameter int NUM_SWITCHES = 4,
    parameter int NUM_DIGITS = 6
) (
    input logic g_clk,
    input logic g_nrst_btn,
    input logic [NUM_PUSHBUTTONS - 1:0]btn,
    input logic [NUM_SWITCHES - 1:0]sw,
    output logic ck_io37,
    output logic ck_io38,
    output logic ck_io39,
    output logic ck_io40,
    output logic ck_io41
    );
    

    /* INPUT SIGNAL SANITIZATION */
    logic [NUM_PUSHBUTTONS-1:0]btn_sync = 4'b0;
    logic [NUM_PUSHBUTTONS-1:0]btn_debounced;
    
    logic [NUM_SWITCHES-1:0]sw_sync = 4'b0;
    logic [NUM_SWITCHES-1:0]sw_debounced;
    logic [NUM_DIGITS-1:0]decimals_out = 6'b001000;

    logic g_rst;
    logic g_nrst_btn_stable;
    assign g_rst = ~g_nrst_btn_stable;

    instant_sig_debouncer #(
        .DEBOUNCE_CYCLES(`MIN_INPUT_HOLD_CYCLES) /* Hold for this many cycles after each transition */
    ) rst_debounce (
        .clk(g_clk),
        .rst(1'b0),
        .ena(1'b1),
        .sig_in(g_nrst_btn),
        .sig_debounced(g_nrst_btn_stable)
    );
    
    always_ff @(posedge g_clk)
    begin
        if(g_rst == 1)
        begin
            btn_sync <= 0;
            sw_sync <= 0;
        end
        else
        begin
            btn_sync <= btn;
            sw_sync <= sw;
        end
    end

    genvar i;
    generate
        for(i = 0; i < NUM_PUSHBUTTONS; i++)
        begin
            instant_sig_debouncer #(
                .DEBOUNCE_CYCLES(`MIN_INPUT_HOLD_CYCLES) /* Hold for this many cycles after each transition */
            ) debounce_btns (
                .clk(g_clk),
                .rst(g_rst),
                .ena(1'b1),
                .sig_in(btn_sync[i]),
                .sig_debounced(btn_debounced[i])
            );
        end
    endgenerate

    generate
        for(i = 0; i < NUM_SWITCHES; i++)
        begin
            instant_sig_debouncer #(
                .DEBOUNCE_CYCLES(`MIN_INPUT_HOLD_CYCLES) /* Hold for this many cycles after each transition */
            ) debounce_switches (
                .clk(g_clk),
                .rst(g_rst),
                .ena(1'b1),
                .sig_in(sw_sync[i]),
                .sig_debounced(sw_debounced[i])
            );
        end
    endgenerate

    /* INTEGRATION */
    timer_integration #(
        .NUM_DIGITS(NUM_DIGITS)
    ) module_timer_integration (
        .g_clk(g_clk),
        .g_rst(g_rst),
        .button_2(btn_debounced[2]),
        .button_3(btn_debounced[3]),
        .all_nrst(ck_io41),
        .control_reg_clk(ck_io40),
        .all_bit_clk(ck_io39),
        .control_data_ser(ck_io38),
        .digit_data_ser(ck_io37)
    );
endmodule
