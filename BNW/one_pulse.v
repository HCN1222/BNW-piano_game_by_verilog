`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/01 21:54:07
// Design Name: 
// Module Name: one_pulse
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


module one_pulse(clk, rst_n, in_trig, out_pulse);

    input clk;
    input rst_n;
    input in_trig;
    output reg out_pulse;

    reg in_trig_delay;
    reg out_pulse_next;

    //buffer input
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            begin
                in_trig_delay <= 1'b0;
            end
        else
            begin
                in_trig_delay <= in_trig;
            end
    end

    //pulse generation
    always@*
    begin
        out_pulse_next = in_trig & (~in_trig_delay);
    end

    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            begin
                out_pulse <= 1'b0;
            end
        else
            begin
                out_pulse <= out_pulse_next;
            end
    end

endmodule
