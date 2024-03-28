`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/02 17:48:58
// Design Name: 
// Module Name: clk_scan_generator
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


module clk_scan_generator(clk, rst_n, clk_out);

    input clk;
    input rst_n;
    output reg [1:0] clk_out;
    reg [14:0] clk_buff;
    reg [16:0] clk_next;

    always@*
    clk_next = {clk_out, clk_buff} + 1'b1;

    always@(posedge clk or negedge rst_n)
    if(~rst_n)
        {clk_out, clk_buff} <= 17'b0;
    else
        {clk_out, clk_buff} <= clk_next;

endmodule

