`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 12:55:50 PM
// Design Name: 
// Module Name: hw_setup_sim
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


module hw_setup_sim # (
    parameter int NUM_DIGITS = 6 //1 - 8
) (
        input logic all_bit_clk,
        input logic all_nrst,
        input logic control_data_ser,
        input logic control_reg_clk,
        input logic digit_data_ser,
        output logic [NUM_DIGITS - 1:0][7:0]digits_7seg,
        output logic [NUM_DIGITS - 1:0][3:0]digits,
        output logic [7:0]control_Q,
        output logic control_Qhp,
        output logic [NUM_DIGITS - 1:0]Qhp,
        output logic [NUM_DIGITS - 1:0]invalid,
        output logic [NUM_DIGITS - 1:0]dec_on
    );
    
    SN74HC595N_sim control_reg(
        .SER(control_data_ser),
        .SRCLK(all_bit_clk),
        .nSRCLR(all_nrst),
        .RCLK(control_reg_clk),
        .nOE(1'b0),
        .Q(control_Q),
        .Qhp(control_Qhp)
    );
    genvar i;
    generate
        for(i = 0; i < NUM_DIGITS; i++)
        begin
            SN74HC595N_sim dig_reg(
                .SER(digit_data_ser),
                .SRCLK(all_bit_clk),
                .nSRCLR(all_nrst),
                .RCLK(control_Q[7-i]),
                .nOE(1'b0),
                .Q(digits_7seg[i]),
                .Qhp(Qhp[i])
            );
            
            seven_seg_reader dig_verif(
                .seven_seg_in((~digits_7seg[i])),
                .dig_out(digits[i]),
                .dec_on(dec_on[i]),
                .invalid(invalid[i])
            );
        end
    endgenerate
    
endmodule
