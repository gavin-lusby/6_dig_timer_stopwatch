`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 12:20:11 PM
// Design Name: 
// Module Name: tb_SN74HC595N
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


module tb_SN74HC595N;
    logic SRCLK;
    logic SER;
    logic RCLK;
    logic nSRCLR;
    logic nOE;
    logic [7:0]Q;
    logic Qhp;
    
    SN74HC595N_sim test_shift_reg(
        .SER(SER),
        .SRCLK(SRCLK),
        .nSRCLR(nSRCLR),
        .RCLK(RCLK),
        .nOE(nOE),
        .Q(Q),
        .Qhp(Qhp)
    );
    
    initial
    begin
        SRCLK = 0;
        forever #0.5 SRCLK = ~SRCLK;
    end
    
    initial
    begin
        SER = 0;
        RCLK = 0;
        nSRCLR = 0;
        nOE = 0;
        #1
        SER = 1;
        nSRCLR = 1;
        #1
        SER = 0;

        for(int i = 0; i < 8; i++)
        begin
            RCLK = 1;
            #0.5
            RCLK = 0;
            #0.5;
        end
        
        RCLK = 1;
        #0.5
        RCLK = 0;
        nOE = 1;
        #0.5

        SER = 1;
        #1
        SER = 0;
        RCLK = 1;
        #0.5
        RCLK = 0;
        nOE = 0;
        #2
        nSRCLR = 0;
        #0.5
        RCLK = 1;
        #0.5
        RCLK = 0;
        nSRCLR = 1;
    end
endmodule
