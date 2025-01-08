`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 10:32:06 PM
// Design Name: 
// Module Name: tb_shift_reg_par_to_ser
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


module tb_shift_reg_par_to_ser;

    logic rst;
    logic clk;
    logic ena;
    logic write;
    logic [7:0]data_in;
    logic data_out;
    shift_reg_par_to_ser #(
        .WIDTH(8)
    ) shift_reg (
        .rst(rst),
        .clk(clk),
        .ena(ena),
        .write(write),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    initial
    begin
        clk = 1;
        forever #0.5 clk = ~clk;
    end
    
    initial
    begin
        rst = 1;
        data_in = 0;
        write = 0;
        ena = 0;
        #5
        ena = 1;
        rst = 0;
        #5
        data_in = 8'b10100101; 
        write = 1;
        #1
        write = 0;
        data_in = 0;
        #10;
        data_in = 8'b10100101; 
        write = 1;
        #1
        write = 0;
        #2
        ena = 0;
        #5
        ena = 1;
        #3
        rst = 1;
        #1
        rst = 0;
        #10
        data_in = 8'b10100101; 
        write = 1;
        #10
        write = 0;
        #5
        write = 1;
        #1
        write = 0;
        #20;
        write = 1;
        data_in = 8'b10000001;
        #1
        write = 0;
        #7;
        write = 1;
        data_in = 8'b10000001;
        #1
        write = 0;
        #7;
        write = 1;
        data_in = 8'b10000001;
        #1
        write = 0;
        #7;
        write = 1;
        data_in = 8'b10000001;
        #1
        write = 0;
        #7;
        
    end
endmodule
