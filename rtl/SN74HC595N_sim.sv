`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 11:54:44 AM
// Design Name: 
// Module Name: SN74HC595N_sim
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


module SN74HC595N_sim(
        input logic SER,
        input logic SRCLK,
        input logic nSRCLR,
        input logic RCLK,
        input logic nOE,
        output logic [7:0]Q,
        output logic Qhp
    );
    
    logic [7:0]Q_int;
    logic [7:0]Q_ext;
    logic Qhp_ext;
    always_comb
    begin
        if(nOE == 1)
        begin
            Q = 8'bZZZZZZZZ;
            Qhp = 1'bZ;
        end
        else
        begin
            Q = Q_ext;
            Qhp = Qhp_ext;
        end
    end

    
    always_ff @(posedge SRCLK, negedge nSRCLR)
    begin
        if(nSRCLR == 0)
        begin
            Qhp_ext <= 1'b0;
        end
        else
        begin
            Q_int <= {SER, Q_int[7:1]};
            Qhp_ext <= Q_int[1];
        end
        
    end
    
    always_ff @(posedge RCLK, negedge nSRCLR)
    begin
        if(nSRCLR == 0)
        begin
            Q_ext <= 8'b00000000;
        end
        else
        begin
            Q_ext <= Q_int;
        end
    end
    
    
endmodule
