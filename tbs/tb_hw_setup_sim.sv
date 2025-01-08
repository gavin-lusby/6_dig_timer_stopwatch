`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2024 02:34:05 PM
// Design Name: 
// Module Name: tb_hw_setup_sim
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


module tb_hw_setup_sim;
    localparam int NUM_DIGITS = 6;
    
    /* Input */
    logic all_bit_clk;
    logic all_nrst;
    logic control_reg_clk_in;
    
    logic start_ctrl_shift;
    logic [47:0]ctrl_shift_in;
    logic start_digit_shift;
    logic [47:0]digit_shift_in;

    /* Intermediate */
    logic control_data_ser;
    logic digit_data_ser;
    logic control_reg_clk = 0;

    /* Output */
    logic [NUM_DIGITS - 1:0][7:0]digits_7seg;
    logic [NUM_DIGITS - 1:0][3:0]digits;
    logic [7:0]control_Q;
    logic control_Qhp;
    logic [NUM_DIGITS - 1:0]Qhp;
    logic [NUM_DIGITS - 1:0]invalid;
    logic [NUM_DIGITS - 1:0]dec_on;


    always_ff @(negedge all_bit_clk)
    begin
        control_reg_clk <= control_reg_clk_in;
    end


    hw_setup_sim # (
        .NUM_DIGITS(NUM_DIGITS)
    ) hw_setup_instance (
        .all_bit_clk(all_bit_clk),
        .all_nrst(all_nrst),
        .control_data_ser(control_data_ser),
        .control_reg_clk(control_reg_clk),
        .digit_data_ser(digit_data_ser),
        .digits_7seg(digits_7seg),
        .digits(digits),
        .control_Q(control_Q),
        .control_Qhp(control_Qhp),
        .Qhp(Qhp),
        .invalid(invalid),
        .dec_on(dec_on)
    );
    
    shift_reg_par_to_ser #(
        .WIDTH(48)
    ) ctrl_bit_ser_reg (
        .clk(all_bit_clk),
        .rst(~all_nrst),
        .ena(1'b1),
        .write(start_ctrl_shift),
        .data_in(ctrl_shift_in),
        .data_out(control_data_ser)
    );
    
    shift_reg_par_to_ser #(
        .WIDTH(48)
    ) digit_bit_ser_reg (
        .clk(all_bit_clk),
        .rst(~all_nrst),
        .ena(1'b1),
        .write(start_digit_shift),
        .data_in(digit_shift_in),
        .data_out(digit_data_ser)
    );
    
    
    
    initial
    begin
        all_bit_clk = 1;
        forever #0.5 all_bit_clk = ~all_bit_clk;
    end
    
    initial
    begin
        all_nrst = 0;

        start_ctrl_shift = 0;
        ctrl_shift_in = '0;
        start_digit_shift = 0;
        digit_shift_in = '0;
        #3
        all_nrst = 1;
        #10;
        ctrl_shift_in = 48'h20_10_08_04_02_01;
        digit_shift_in = 48'h41_49_99_0D_25_9F;
        start_ctrl_shift = 1;
        start_digit_shift = 1;
        #1
        start_ctrl_shift = 0;
        start_digit_shift = 0;
        #7
        //CTRL SELECTS
        #8
        #8
        #8
        #8
        #8
        
        //Next word / end of last word
        digit_shift_in = 48'h63_C1_11_09_01_1F;
        start_ctrl_shift = 1;
        start_digit_shift = 1;
        #1
        start_ctrl_shift = 0;
        start_digit_shift = 0;

    end
    initial
    begin
        control_reg_clk_in = 0;
        #3
        #10
        #8
        //CTRL SELECTS
        for (int i = 0; i < NUM_DIGITS; i++)
        begin
            control_reg_clk_in = 1;
            #1
            control_reg_clk_in = 0;
            #7;
        end
        //CTRL SELECTS
        for (int i = 0; i < NUM_DIGITS; i++)
        begin
            control_reg_clk_in = 1;
            #1
            control_reg_clk_in = 0;
            #7;
        end
        
    end
    
    
endmodule
