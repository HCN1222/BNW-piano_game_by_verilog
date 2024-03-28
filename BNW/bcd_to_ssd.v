`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/01 22:04:20
// Design Name: 
// Module Name: BCD_to_SSD
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

//    define segment codes
    `define SS_0 8'b00000011
    `define SS_1 8'b10011111
    `define SS_2 8'b00100101
    `define SS_3 8'b00001101
    `define SS_4 8'b10011001
    `define SS_5 8'b01001001
    `define SS_6 8'b01000001
    `define SS_7 8'b00011111
    `define SS_8 8'b00000001
    `define SS_9 8'b00001001
    `define SS_V 8'b10000011
    `define SS_A 8'b00010001
    `define SS_L 8'b11100011
    `define SS_P 8'b00110001
    `define SS_minus 8'b11111101
    `define SS_dark 8'b11111111

module bcd_to_ssd(bcd, ssd);

    input [3:0] bcd;
    output reg [7:0] ssd;
    
    always @*
    case(bcd)
        4'd0: ssd = `SS_0;
        4'd1: ssd = `SS_1;
        4'd2: ssd = `SS_2;
        4'd3: ssd = `SS_3;
        4'd4: ssd = `SS_4;
        4'd5: ssd = `SS_5;
        4'd6: ssd = `SS_6;
        4'd7: ssd = `SS_7;
        4'd8: ssd = `SS_8;
        4'd9: ssd = `SS_9;
        4'd10: ssd = `SS_V;
        4'd11: ssd = `SS_A;
        4'd12: ssd = `SS_L;
        4'd13: ssd = `SS_P;
        4'd14: ssd = `SS_minus;
        4'd15: ssd = `SS_dark;
        default: ssd = 8'b11111111;
    endcase
endmodule
