`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 17:26:38
// Design Name: 
// Module Name: clk_25M_generator
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


module clk_25M_generator( clk, rst_n, clk_out );

    input clk;
    input rst_n;
    
    output clk_out;
    
    reg [1:0] cnt, next_cnt;

    assign clk_out = cnt [1];
    
    always@*
    next_cnt = cnt + 1;

    always@( posedge clk or negedge rst_n )
    if( ~rst_n )
        cnt = 0;
    else
        cnt = next_cnt;

endmodule
