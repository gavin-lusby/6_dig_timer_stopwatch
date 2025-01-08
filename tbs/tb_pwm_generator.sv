`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2024 04:49:57 PM
// Design Name: 
// Module Name: tb_pwm_generator
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


module tb_pwm_generator;
    logic clk;
    logic rst;
    logic ena;
    logic pulse_out0;
    logic [1:0]pulse_out1;
    logic [2:0]pulse_out2;
    logic [3:0]pulse_out3;
    logic [5:0]pulse_out5_0;
    logic [5:0]pulse_out5_1;
    logic [5:0]pulse_out5_2;
    logic [5:0]pulse_out5_3;
    logic [5:0]pulse_out5_4;
    
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
        .PRESCALER(0),
        .PULSE_WIDTH(0),
        .OFFSET(0)
    ) pulser0_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out0)
    );
    
    //------------------------
    //------------------------
    //------------------------
    
    pwm_generator #(
        .PRESCALER(1),
        .PULSE_WIDTH(0),
        .OFFSET(0)
    ) pulser1_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out1[0])
    );
    
    pwm_generator #(
        .PRESCALER(1),
        .PULSE_WIDTH(1),
        .OFFSET(0)
    ) pulser1_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out1[1])
    );
    
    //------------------------
    //------------------------
    //------------------------
    
    pwm_generator #(
        .PRESCALER(2),
        .PULSE_WIDTH(0),
        .OFFSET(0)
    ) pulser2_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out2[0])
    );
    
    pwm_generator #(
        .PRESCALER(2),
        .PULSE_WIDTH(1),
        .OFFSET(0)
    ) pulser2_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out2[1])
    );
    
    pwm_generator #(
        .PRESCALER(2),
        .PULSE_WIDTH(2),
        .OFFSET(0)
    ) pulser2_2 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out2[2])
    );
    //------------------------
    //------------------------
    //------------------------
    
    pwm_generator #(
        .PRESCALER(3),
        .PULSE_WIDTH(0),
        .OFFSET(0)
    ) pulser3_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out3[0])
    );
    
    pwm_generator #(
        .PRESCALER(3),
        .PULSE_WIDTH(1),
        .OFFSET(0)
    ) pulser3_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out3[1])
    );
    
    pwm_generator #(
        .PRESCALER(3),
        .PULSE_WIDTH(2),
        .OFFSET(0)
    ) pulser3_2 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out3[2])
    );
    
    pwm_generator #(
        .PRESCALER(3),
        .PULSE_WIDTH(3),
        .OFFSET(0)
    ) pulser3_3 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out3[3])
    );
    
    //------------------------
    //------------------------
    //------------------------
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(0),
        .OFFSET(0)
    ) pulser5_0_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_0[0])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(1),
        .OFFSET(0)
    ) pulser5_0_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_0[1])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(2),
        .OFFSET(0)
    ) pulser5_0_2 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_0[2])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(3),
        .OFFSET(0)
    ) pulser5_0_3 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_0[3])
    );

    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(4),
        .OFFSET(0)
    ) pulser5_0_4 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_0[4])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(5),
        .OFFSET(0)
    ) pulser5_0_5 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_0[5])
    );
    //------------------------
    //------------------------
    //------------------------
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(0),
        .OFFSET(1)
    ) pulser5_1_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_1[0])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(1),
        .OFFSET(1)
    ) pulser5_1_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_1[1])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(2),
        .OFFSET(1)
    ) pulser5_1_2 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_1[2])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(3),
        .OFFSET(1)
    ) pulser5_1_3 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_1[3])
    );

    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(4),
        .OFFSET(1)
    ) pulser5_1_4 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_1[4])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(5),
        .OFFSET(1)
    ) pulser5_1_5 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_1[5])
    );
    //------------------------
    //------------------------
    //------------------------
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(0),
        .OFFSET(2)
    ) pulser5_2_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_2[0])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(1),
        .OFFSET(2)
    ) pulser5_2_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_2[1])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(2),
        .OFFSET(2)
    ) pulser5_2_2 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_2[2])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(3),
        .OFFSET(2)
    ) pulser5_2_3 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_2[3])
    );

    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(4),
        .OFFSET(2)
    ) pulser5_2_4 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_2[4])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(5),
        .OFFSET(2)
    ) pulser5_2_5 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_2[5])
    );
    //------------------------
    //------------------------
    //------------------------
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(0),
        .OFFSET(3)
    ) pulser5_3_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_3[0])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(1),
        .OFFSET(3)
    ) pulser5_3_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_3[1])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(2),
        .OFFSET(3)
    ) pulser5_3_2 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_3[2])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(3),
        .OFFSET(3)
    ) pulser5_3_3 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_3[3])
    );

    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(4),
        .OFFSET(3)
    ) pulser5_3_4 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_3[4])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(5),
        .OFFSET(3)
    ) pulser5_3_5 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_3[5])
    );
    //------------------------
    //------------------------
    //------------------------
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(0),
        .OFFSET(4)
    ) pulser5_4_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_4[0])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(1),
        .OFFSET(4)
    ) pulser5_4_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_4[1])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(2),
        .OFFSET(4)
    ) pulser5_4_2 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_4[2])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(3),
        .OFFSET(4)
    ) pulser5_4_3 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_4[3])
    );

    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(4),
        .OFFSET(4)
    ) pulser5_4_4 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_4[4])
    );
    
    pwm_generator #(
        .PRESCALER(5),
        .PULSE_WIDTH(5),
        .OFFSET(4)
    ) pulser5_4_5 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pulse_out(pulse_out5_4[5])
    );
endmodule
