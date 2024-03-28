`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/01 22:04:20
// Design Name: 
// Module Name: show
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

module show( four_bcd, three_bcd, two_bcd, one_bcd, clk_scan, ctl, ssd_out );

input [3:0] four_bcd, three_bcd, two_bcd, one_bcd;
input [1:0] clk_scan;
output [3:0] ctl;
output [7:0] ssd_out;

wire [7:0] four_ssd, three_ssd, two_ssd, one_ssd;

bcd_to_ssd FOR ( .bcd( four_bcd ), .ssd( four_ssd ) );
bcd_to_ssd THR ( .bcd( three_bcd ), .ssd( three_ssd ) );
bcd_to_ssd TWO ( .bcd( two_bcd ), .ssd( two_ssd ) );
bcd_to_ssd ONE ( .bcd( one_bcd ), .ssd( one_ssd ) );

scan SC ( .four( four_ssd ), .three( three_ssd ), .two( two_ssd ), .one( one_ssd ), .clk_scan( clk_scan ), .ctl( ctl ), .ssd_out( ssd_out ) );

endmodule
