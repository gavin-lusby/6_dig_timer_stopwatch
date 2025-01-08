`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 07:53:53 PM
// Design Name: 
// Module Name: tb_debounce
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


module tb_debounce;
    logic clk;
    logic rst;
    logic sig_in;
    logic [3:0]sig_debounced;

    initial
    begin
        clk = 1;
        forever #0.5 clk = ~clk;
    end
    
    initial
    begin
        rst = 1;
        sig_in = 0;
        #10
        rst = 0;
        sig_in = 1;
        #6
        sig_in = 0;
        #6
        rst = 1;
        sig_in = 1;
        #6
        rst = 0;
        #6
        sig_in = 0;
        #40
        sig_in = 1;
        #40
        sig_in = 0;
        #100
        sig_in = 1;
        #30
        sig_in = 0;
        #100
        sig_in = 1;
        #31
        sig_in = 0;
        #100
        sig_in = 1;
        #32
        sig_in = 0;
        #100
        sig_in = 1;
        #33
        sig_in = 0;
        #100
        sig_in = 1;
        #34
        sig_in = 0;
        #100
        sig_in = 1;
        #200
        
        
        sig_in = 0;
        #30
        sig_in = 1;
        #100
        sig_in = 0;
        #31
        sig_in = 1;
        #100
        sig_in = 0;
        #32
        sig_in = 1;
        #100
        sig_in = 0;
        #33
        sig_in = 1;
        #100
        sig_in = 0;
        #34
        sig_in = 1;
        #100;
    end

    sig_debouncer #(
        .DEBOUNCE_CYCLES(15)
    ) debounce0 (
        .clk(clk),
        .rst(rst),
        .ena(1'b1),
        .sig_in(sig_in),
        .sig_debounced(sig_debounced[0])
    );
    sig_debouncer #(
        .DEBOUNCE_CYCLES(16)
    ) debounce1 (
        .clk(clk),
        .rst(rst),
        .ena(1'b1),
        .sig_in(sig_in),
        .sig_debounced(sig_debounced[1])
    );
    
    sig_debouncer #(
        .DEBOUNCE_CYCLES(17)
    ) debounce2 (
        .clk(clk),
        .rst(rst),
        .ena(1'b1),
        .sig_in(sig_in),
        .sig_debounced(sig_debounced[2])
    );

    sig_debouncer #(
        .DEBOUNCE_CYCLES(4)
    ) debounce3 (
        .clk(clk),
        .rst(rst),
        .ena(1'b1),
        .sig_in(sig_in),
        .sig_debounced(sig_debounced[3])
    );
endmodule
