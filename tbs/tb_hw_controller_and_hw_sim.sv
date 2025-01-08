`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 04:49:15 PM
// Design Name: 
// Module Name: tb_hw_controller_and_hw_sim
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


module tb_hw_controller_and_hw_sim;
    localparam int NUM_DIGITS = 6;
    //hw controller input
    logic clk;
    logic rst;
    logic ena;
    logic [5:0][7:0]dig_data_in; //Digit data in. 

    
    //hw controller output / hw sim input
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

    hw_registers_controller # (
        .REG_SIZE(8),
        .NUM_DATA_REG(NUM_DIGITS),
        .CYCLES_PER_UPDATE(100),
        .CLK_PRESCALER(1000)
    ) hw_reg_interface (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .dig_data_in(dig_data_in),
        .all_bit_clk(all_bit_clk),
        .all_nrst(all_nrst),
        .control_data_ser(control_data_ser),
        .control_reg_clk(control_reg_clk),
        .digit_data_ser(digit_data_ser)
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
        clk = 1;
        forever #0.5 clk = ~clk;
    end
    initial
    begin
       rst = 1;
       ena = 0;
       dig_data_in = '0;
       #10
       rst = 0;
       ena = 1;
       dig_data_in = 48'h41_49_99_0D_25_9F;
       #700
       dig_data_in = 48'h63_C1_11_09_01_1F;
    end
    
endmodule


