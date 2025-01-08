`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 08:05:04 PM
// Design Name: 
// Module Name: seven_seg_reader
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


module seven_seg_reader(
        input logic [7:0]seven_seg_in, /* 8-bit input from 7-seg display */
        output logic [3:0]dig_out, /* Decimal digit output as binary */
        output logic dec_on, /* Decimal pt on/off */
        output logic invalid /* is digit invalid */
    );
    always_comb begin
        case (seven_seg_in[7:1])
            7'b1111110: 
            begin
                dig_out = 4'h0;
                invalid = 0;
            end
            7'b0110000: 
            begin
                dig_out = 4'h1;
                invalid = 0;
            end
            7'b1101101: 
            begin
                dig_out = 4'h2;
                invalid = 0;
            end
            7'b1111001: 
            begin
                dig_out = 4'h3;
                invalid = 0;
            end
            7'b0110011: 
            begin
                dig_out = 4'h4;
                invalid = 0;
            end
            7'b1011011: 
            begin
                dig_out = 4'h5;
                invalid = 0;
            end
            7'b1011111: 
            begin
                dig_out = 4'h6;
                invalid = 0;
            end
            7'b1110000: 
            begin
                dig_out = 4'h7;
                invalid = 0;
            end
            7'b1111111: 
            begin
                dig_out = 4'h8;
                invalid = 0;
            end
            7'b1111011: 
            begin
                dig_out = 4'h9;
                invalid = 0;
            end
            7'b1110111: 
            begin
                dig_out = 4'hA;
                invalid = 0;
            end
            7'b0011111: 
            begin
                dig_out = 4'hb;
                invalid = 0;
            end
            7'b1001110: 
            begin
                dig_out = 4'hC;
                invalid = 0;
            end
            7'b0111101: 
            begin
                dig_out = 4'hd;
                invalid = 0;
            end
            7'b1001111: 
            begin
                dig_out = 4'hE;
                invalid = 0;
            end
            7'b1000111: 
            begin
                dig_out = 4'hF;
                invalid = 0;
            end
            default: 
            begin
                dig_out = 4'h0;
                invalid = 1;
            end
        endcase
        dec_on = seven_seg_in[0];
    end
endmodule
