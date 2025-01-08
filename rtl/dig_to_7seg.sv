`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 06:46:10 PM
// Design Name: 
// Module Name: dig_to_7seg
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


module dig_to_seven_seg(
        input logic [3:0]dig_in, /* Decimal digit as binary */
        input logic dec_on, /* Decimal pt on/off */
        output logic [7:0]seven_seg_out /* 8-bit output to 7-seg display */
    );
    always_comb begin
        case (dig_in)
            4'h0: seven_seg_out[7:1] = 7'b1111110;
            4'h1: seven_seg_out[7:1] = 7'b0110000;
            4'h2: seven_seg_out[7:1] = 7'b1101101;
            4'h3: seven_seg_out[7:1] = 7'b1111001;
            4'h4: seven_seg_out[7:1] = 7'b0110011;
            4'h5: seven_seg_out[7:1] = 7'b1011011;
            4'h6: seven_seg_out[7:1] = 7'b1011111;
            4'h7: seven_seg_out[7:1] = 7'b1110000;
            4'h8: seven_seg_out[7:1] = 7'b1111111;
            4'h9: seven_seg_out[7:1] = 7'b1111011;
            4'hA: seven_seg_out[7:1] = 7'b1110111;
            4'hb: seven_seg_out[7:1] = 7'b0011111;
            4'hC: seven_seg_out[7:1] = 7'b1001110;
            4'hd: seven_seg_out[7:1] = 7'b0111101;
            4'hE: seven_seg_out[7:1] = 7'b1001111;
            4'hF: seven_seg_out[7:1] = 7'b1000111;
        endcase
        seven_seg_out[0] = dec_on;
    end
endmodule
