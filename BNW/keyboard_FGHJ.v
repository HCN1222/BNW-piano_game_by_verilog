`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 23:58:29
// Design Name: 
// Module Name: keyboard_FGHJ
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


module keyboard_FGHJ (  /*input*/ key_down,
 /*output*/ f_pressed, g_pressed, h_pressed, j_pressed );
 
 input [ 511:0 ] key_down;
 output f_pressed, g_pressed, h_pressed, j_pressed;
 
 assign f_pressed = ( key_down[9'h2B] == 1 );
 assign g_pressed = ( key_down[9'h34] == 1 );
 assign h_pressed = ( key_down[9'h33] == 1 );
 assign j_pressed = ( key_down[9'h3B] == 1 );

 
 
endmodule
