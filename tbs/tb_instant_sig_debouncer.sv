`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2024 06:15:04 PM
// Design Name: 
// Module Name: tb_instant_sig_debouncer
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


module tb_instant_sig_debouncer;
    logic clk;
    logic rst;
    logic nrst;
    logic rst_out;
    logic nrst_out;
    logic sig_in;
    logic [3:0]sig_debounced;
    
    assign rst_out = ~nrst_out;
    initial
    begin
        clk = 1;
        forever #0.5 clk = ~clk;
    end
    
    initial
    begin
        rst = 1;
        nrst = 0;
        sig_in = 0;
        #10
        rst = 0;
        nrst = 1;
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
        #1
        sig_in = 0;
        #40;
        sig_in = 1;
        #3
        sig_in = 0;
        #40;
        sig_in = 1;
        #4
        sig_in = 0;
        #40;
        sig_in = 1;
        #5
        sig_in = 0;
        #40;
        sig_in = 1;
        #6
        sig_in = 0;
        #40;
        sig_in = 1;
        #7
        sig_in = 0;
        #40;
        
    end

    instant_sig_debouncer #(
        .DEBOUNCE_CYCLES(15)
    ) debounce0 (
        .clk(clk),
        .rst(rst),
        .ena(1'b1),
        .sig_in(sig_in),
        .sig_debounced(sig_debounced[0])
    );
    instant_sig_debouncer #(
        .DEBOUNCE_CYCLES(16)
    ) debounce1 (
        .clk(clk),
        .rst(rst),
        .ena(1'b1),
        .sig_in(sig_in),
        .sig_debounced(sig_debounced[1])
    );
    
    instant_sig_debouncer #(
        .DEBOUNCE_CYCLES(17)
    ) debounce2 (
        .clk(clk),
        .rst(rst),
        .ena(1'b1),
        .sig_in(sig_in),
        .sig_debounced(sig_debounced[2])
    );

    instant_sig_debouncer #(
        .DEBOUNCE_CYCLES(4)
    ) debounce3 (
        .clk(clk),
        .rst(rst),
        .ena(1'b1),
        .sig_in(sig_in),
        .sig_debounced(sig_debounced[3])
    );
    
    instant_sig_debouncer #(
        .DEBOUNCE_CYCLES(20_000)
    ) reset_debouncer (
        .clk(clk),
        .rst(~nrst),
        .ena(1'b1),
        .sig_in(nrst),
        .sig_debounced(nrst_out)
    );
endmodule
