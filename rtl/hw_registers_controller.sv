`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 12:45:57 PM
// Design Name: 
// Module Name: hw_registers_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: The idea of this module is to act as a gate between any internal
//  Signaling and the hardware output, to protect against breaking any hardware.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

/* Hard coded sequence to enable reg_write signals to each 7seg from right to left */
`define CONTROL_DATA_SEQUENCE_6_DIG 48'h04_08_10_20_40_80

module hw_registers_controller # (
    parameter int REG_SIZE = 8, /* Number of bits per ctrl/data register. ctrl/data registers must be same size. */
    parameter int NUM_DATA_REG = 6, /* Valid input is 1-REG_SIZE */
    parameter int CYCLES_PER_UPDATE = 100, /* Valid input is >= NUM_DATA_REG*REG_SIZE */
    parameter int CLK_PRESCALER = 1000 /* Amount to slow down for clock. Might be needed for timing reasons */
    ) (
    input logic clk,
    input logic rst,
    input logic ena,
    input logic [NUM_DATA_REG - 1:0][REG_SIZE - 1:0]dig_data_in,
    output logic all_bit_clk, /* outgoing SRCLK for all shift registers. */
    output logic all_nrst, /* outgoing nSRCLR signal for all shift registers. */
    output logic control_data_ser, /* outgoing SER for control shift register. */
    output logic control_reg_clk, /* outgoing RCLK for control shift register. Externally delayed to neg edge of SRCLK.*/
    output logic digit_data_ser /* outgoing SER for digit shift register. */
    );
    
    generate
        if ((NUM_DATA_REG > REG_SIZE) || (NUM_DATA_REG < 1))
        begin
            $error("Number of data register must be from 1-REG_SIZE");
        end
        else if(CYCLES_PER_UPDATE < NUM_DATA_REG*REG_SIZE)
        begin
            /* This is the minimum number of active cycles per update interval, so our update interval must be >= */
            $error("Number of cycles per update must be greater than or equal to NUM_DATA_REG*REG_SIZE");
        end
    endgenerate

    logic active_ena; /* Enable signal high during active portion of update interval */
    logic active_ena_delayed; /* Delayed active_ena used for control register RCLK signal to pulse AFTER each data is sent */
    logic shift_reg_write;
    logic control_reg_clk_pos; /* Pos edge control reg RCLK. Needs to be delayed to falling edge of bit clock for timing reasons */
    
    logic prescaler_ena; /* Enable signal to controller slow down due to clock prescaling */
    logic all_bit_clk_ungated;

    assign all_nrst = ~rst;

    generate
        if(CLK_PRESCALER > 1)
        begin
            logic prev_all_bit_clk_ungated;
        
            /* Generate enable signal once every CLK_PRESCALER clock cycles */
            pwm_generator #(
                .PRESCALER(CLK_PRESCALER),
                .PULSE_WIDTH(1),
                .OFFSET(0)
            ) prescaler_enable_generator (
                .clk(clk),
                .rst(rst),
                .ena(ena),
                .pulse_out(prescaler_ena)
            );
            
            /* Generate serial clock signal with freq freq(clk)/CLK_PRESCALER */
            pwm_generator #(
                .PRESCALER(CLK_PRESCALER),
                .PULSE_WIDTH(CLK_PRESCALER/2),
                .OFFSET(0)
            ) bit_clk_generator (
                .clk(clk),
                .rst(rst),
                .ena(ena),
                .pulse_out(all_bit_clk_ungated)
            );

            /* Sketchy falling edge detector to avoid timing violation */
            always_ff @(posedge clk)
            begin
                if((prev_all_bit_clk_ungated == 1) && (all_bit_clk_ungated == 0))
                begin
                    control_reg_clk <= control_reg_clk_pos;
                end
                prev_all_bit_clk_ungated <= all_bit_clk_ungated;
            end
            /* Not & with ena because ena already controls all_bit_clk_ungated */
            assign all_bit_clk = all_bit_clk_ungated & (active_ena | active_ena_delayed) & (~rst);
        end
        else
        begin
            assign prescaler_ena = ena;
            assign all_bit_clk = clk & ena & (active_ena | active_ena_delayed) & (~rst);
            
            logic nclk; /* Needed to sample contrl_reg_clk on neg edge */
            assign nclk = ~clk;
            always_ff @(posedge nclk)
            begin
                control_reg_clk <= control_reg_clk_pos;
            end
        end
    endgenerate

    

    /* Generate controller enable signal for active portion of one update interval */ 
    pwm_generator #(
        .PRESCALER(CYCLES_PER_UPDATE),
        .PULSE_WIDTH(NUM_DATA_REG*REG_SIZE), /* Active length of update interval */
        .OFFSET(0)
    ) active_enable_sig_generator (
        .clk(clk),
        .rst(rst),
        .ena(ena & prescaler_ena),
        .pulse_out(active_ena)
    );
    

    /* Here we are using debouncer to delay enable signal*/
    sig_debouncer #(
        .DEBOUNCE_CYCLES(REG_SIZE-1) /* Delay active_ena to pulse AFTER each reg data. -1 due to delta cycles */
    ) total_ena_delayer (
        .clk(clk),
        .rst(rst),
        .ena(ena & prescaler_ena),
        .sig_in(active_ena),
        .sig_debounced(active_ena_delayed)
    );

    /*
    Generate ctrl register RCLK signal after each digit is transmitted to
    enable the RCLK signal of the corresponding digit register
    */
    pwm_generator #(
        .PRESCALER(REG_SIZE),
        .PULSE_WIDTH(1),
        .OFFSET(0)
    ) ctrl_reg_write_gen (
        .clk(clk),
        .rst(rst),
        .ena(ena & active_ena_delayed & prescaler_ena),
        .pulse_out(control_reg_clk_pos)
    );
    
   
   /* Generate one write signal per update */
   pwm_generator #(
        .PRESCALER(CYCLES_PER_UPDATE),
        .PULSE_WIDTH(1),
        .OFFSET(0)
    ) reg_write_sig_gen (
        .clk(clk),
        .rst(rst),
        .ena(ena & prescaler_ena),
        .pulse_out(shift_reg_write)
    );
    
    /* Generate Control register serial data */
    shift_reg_par_to_ser #(
        .WIDTH(NUM_DATA_REG*REG_SIZE)
    ) ctrl_bit_ser_reg (
        .clk(clk),
        .rst(rst),
        .ena(ena & active_ena & prescaler_ena),
        .write(shift_reg_write & prescaler_ena),
        .data_in(`CONTROL_DATA_SEQUENCE_6_DIG),
        .data_out(control_data_ser)
    );
    
    /* Generate digit register serial data */
    shift_reg_par_to_ser #(
        .WIDTH(NUM_DATA_REG*REG_SIZE)
    ) digit_bit_ser_reg (
        .clk(clk),
        .rst(rst),
        .ena(ena & active_ena & prescaler_ena),
        .write(shift_reg_write & prescaler_ena),
        .data_in(dig_data_in),
        .data_out(digit_data_ser)
    );
    
    
    
    

endmodule

