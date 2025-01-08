`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2024 04:49:57 PM
// Design Name: 
// Module Name: tb_pwm_generator_2
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


module tb_pwm_generator_2;
    logic clk;
    logic rst;
    logic ena;
    logic pulse_inter;
    logic pulse_out;
    
    initial
    begin
        clk = 1;
        forever #0.5 clk = ~clk;
    end
    
    initial
    begin
        rst  = 1;
        ena = 0;
        #10;
        rst = 0;
        ena = 1;
    end

    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(1),
        .OFFSET(0)
    ) pulser_in (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_inter)
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(1),
        .OFFSET(0)
    ) pulser_out (
        .clk(clk),
        .rst(rst),
        .ena(pulse_inter),
        .pulse_out(pulse_out)
    );
    
  
endmodule
