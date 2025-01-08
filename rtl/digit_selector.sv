`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 04:28:15 PM
// Design Name: 
// Module Name: digit_selector
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


module digit_selector #(
    parameter int IN_SIZE=17, /* Number of digits to input */
    parameter int OUT_SIZE=6, /* Number of digits to output */
    parameter int DIG_WIDTH=4 /* Bit width of each digit */
) (
    input logic [IN_SIZE-1:0][DIG_WIDTH-1:0]in_digits,
    input logic [SHIFT_AMT_SIZE-1:0]shift_amount,
    output logic [OUT_SIZE-1:0][DIG_WIDTH-1:0]out_digits
    );
    
    localparam int SHIFT_AMT_SIZE =  $clog2(IN_SIZE - OUT_SIZE + 1);

    assign out_digits = in_digits[shift_amount +: OUT_SIZE];

    
endmodule
