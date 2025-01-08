`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 06:16:26 PM
// Design Name: 
// Module Name: tb_toplevel
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


module tb_toplevel;
    localparam int NUM_DIGITS = 6;
    //toplevel input
    logic g_clk;
    logic g_nrst_btn;
    logic [3:0]btn;
    logic [3:0]sw;
    
    
    //toplevel output / hw sim input
    logic all_bit_clk; //Bit clock for all shift registers
    logic all_nrst; //nRST signal for all shift registers
    logic control_data_ser; //Serial data for control shift register
    logic digit_data_ser; //Serial data for digit shift register
    logic control_reg_clk; //RCLK signal for control shift register. Needs to be on neg edge for timing reasons

    // hw sim output
    logic [NUM_DIGITS - 1:0][7:0]digits_7seg;
    logic [NUM_DIGITS - 1:0][3:0]digits;
    logic [7:0]control_Q;
    logic control_Qhp;
    logic [NUM_DIGITS - 1:0]Qhp;
    logic [NUM_DIGITS - 1:0]invalid;
    logic [NUM_DIGITS - 1:0]dec_on;

    toplevel # (
        .NUM_PUSHBUTTONS(4),
        .NUM_SWITCHES(4),
        .NUM_DIGITS(NUM_DIGITS)
    ) module_toplevel (
        .g_clk(g_clk),
        .g_nrst_btn(g_nrst_btn),
        .btn(btn),
        .sw(sw),
        .ck_io37(digit_data_ser),
        .ck_io38(control_data_ser),
        .ck_io39(all_bit_clk),
        .ck_io40(control_reg_clk),
        .ck_io41(all_nrst)
        );
 
    hw_setup_sim # (
        .NUM_DIGITS(NUM_DIGITS)
    ) hw_setup_instance (
        .all_bit_clk(all_bit_clk),
        .all_nrst(all_nrst),
        .control_data_ser(control_data_ser),
        .control_reg_clk(control_reg_clk),
        .digit_data_ser(digit_data_ser),
        .digits_7seg(digits_7seg),
        .digits(digits),
        .control_Q(control_Q),
        .control_Qhp(control_Qhp),
        .Qhp(Qhp),
        .invalid(invalid),
        .dec_on(dec_on)
    );
   
    initial
    begin
        g_clk = 1;
        forever #0.5 g_clk = ~g_clk;
    end
    initial
    begin
        g_nrst_btn = 1;
        btn = '0;
        sw = '0;
        #2
        g_nrst_btn = 0;
        #10
        g_nrst_btn = 1;
        #10
        g_nrst_btn = 0;
        #10
        g_nrst_btn = 1;
        #50000
        g_nrst_btn = 0;
        #1
        g_nrst_btn = 1;
    end
    
endmodule
