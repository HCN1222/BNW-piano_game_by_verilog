`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/17 16:27:37
// Design Name: 
// Module Name: long_and_short_press
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


module long_and_short_press( clk, rst_n, in, long_press_lv, short_press_lv );

    input clk;
    input in;
    input rst_n;
    output reg long_press_lv, short_press_lv;
    
    reg delay;

    reg [7:0] press_cnt, press_cnt_next;

    always@*
    if( in )
        begin
            press_cnt_next = press_cnt + 8'b1;
        end
    else
        begin
            press_cnt_next = 8'b0;
        end

    always@*
    begin
        if(press_cnt >= 8'd100)
            begin
                long_press_lv = 1'b1;
            end
        else
            begin
                long_press_lv = 1'b0;
            end
        short_press_lv = ( ~in ) && ( delay ) && ( ~long_press_lv );
    end
    
    always@(posedge clk or negedge rst_n)
    if( ~rst_n )
        begin
            delay = 1'b0;
            press_cnt = 8'b0;
        end
    else
        begin
            delay = in;
            press_cnt = press_cnt_next;
        end
endmodule
