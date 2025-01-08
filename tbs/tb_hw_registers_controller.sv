`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 03:47:17 PM
// Design Name: 
// Module Name: tb_hw_registers_controller
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


module tb_hw_registers_controller;

    logic clk;
    logic rst;
    logic ena;
    logic [5:0][7:0]dig_data_in; //Digit data in. 
    logic all_bit_clk; //Bit clock for all shift registers
    logic all_nrst; //nRST signal for all shift registers
    logic control_data_ser; //Serial data for control shift 
    logic digit_data_ser; //Serial data for digit shift register
    logic control_reg_clk; //RCLK signal for control shift register. Needs to be on neg edge for timing reasons

    hw_registers_controller # (
        .REG_SIZE(8),
        .NUM_DATA_REG(6),
        .CYCLES_PER_UPDATE(48)
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
       #48
       dig_data_in = 48'h63_C1_11_09_01_1F;
    end
endmodule
