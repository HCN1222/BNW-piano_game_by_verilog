`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/30 01:30:04
// Design Name: 
// Module Name: mem_addr_gen
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


module mem_addr_gen ( /*input*/h_cnt, v_cnt, h_pos, v_pos, width, max,
/*output*/pixel_addr );

input [9:0] h_cnt, v_cnt;
input [9:0] h_pos,v_pos;
input [9:0] width;
input [16:0] max;

output wire [16:0] pixel_addr;

assign pixel_addr =  ( ( h_cnt - h_pos ) + width*( v_cnt - v_pos ) ) % max ;

endmodule
