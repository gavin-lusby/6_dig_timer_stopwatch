`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 06:16:26 PM
// Design Name: 
// Module Name: tb_dig_to_seven_seg
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


module tb_dig_to_seven_seg;
    logic [3:0]dig_in;
    logic dec_in;
    logic [7:0]seven_seg;
    logic [3:0]dig_out;
    logic dec_out;
    logic invalid;
    
    
    dig_to_seven_seg seven_seg_conv_1(
        .dig_in(dig_in),
        .dec_on(dec_in),
        .seven_seg_out(seven_seg)
    );
    
    seven_seg_reader seven_seg_verif_1(
        .dec_on(dec_out),
        .seven_seg_in(seven_seg),
        .dig_out(dig_out),
        .invalid(invalid)
    );
    
    initial begin
        dig_in = 0;
        forever #1 dig_in = dig_in+1;
    end
    initial begin
        dec_in = 0;
        forever #16 dec_in = ~dec_in;
    end
endmodule
