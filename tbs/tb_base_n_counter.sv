`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 10:50:45 AM
// Design Name: 
// Module Name: tb_base_n_counter
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


module tb_base_n_counter;
    logic clk;
    logic rst;
    logic ena;

    logic counter_2;
    logic ena_next_2;

    logic [3:0]counter_10_3;
    logic [3:0]counter_10_2;
    logic [3:0]counter_10_1;
    logic [3:0]counter_10_0;
    logic [13:0]counter_10_total;
    logic [3:0]ena_next_10;
    logic ena_next_10_3;
    logic ena_next_10_2;
    logic ena_next_10_1;
    logic ena_next_10_0;
    
    assign ena_next_10_0 = ena_next_10[0];
    assign ena_next_10_1 = ena_next_10_0 & ena_next_10[1];
    assign ena_next_10_2 = ena_next_10_1 & ena_next_10[2];
    assign ena_next_10_3 = ena_next_10_2 & ena_next_10[3];
    
    assign counter_10_total = counter_10_0 + (10*counter_10_1) + (100*counter_10_2) + (1000*counter_10_3);


    initial
    begin
        clk = 1;
        forever #0.5 clk = ~clk;
    end
    
    initial
    begin
        rst = 1;
        ena = 1;
        #10
        rst = 0;
    end
    
    base_n_counter # (
        .BASE(2)
    ) base_2_counter (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .count_out(counter_2),
        .ena_next(ena_next_2)
    );
    
    base_n_counter # (
        .BASE(10)
    ) base_10_counter_0 (
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .count_out(counter_10_0),
        .ena_next(ena_next_10[0])
    );
    
    base_n_counter # (
        .BASE(10)
    ) base_10_counter_1 (
        .clk(clk),
        .rst(rst),
        .ena(ena_next_10_0),
        .count_out(counter_10_1),
        .ena_next(ena_next_10[1])
    );
    
    base_n_counter # (
        .BASE(10)
    ) base_10_counter_2 (
        .clk(clk),
        .rst(rst),
        .ena(ena_next_10_1),
        .count_out(counter_10_2),
        .ena_next(ena_next_10[2])
    );
    
    base_n_counter # (
        .BASE(10)
    ) base_10_counter_3 (
        .clk(clk),
        .rst(rst),
        .ena(ena_next_10_2),
        .count_out(counter_10_3),
        .ena_next(ena_next_10[3])
    );
endmodule
