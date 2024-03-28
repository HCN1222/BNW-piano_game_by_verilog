`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 00:33:54
// Design Name: 
// Module Name: stopwatch_show
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
`include "global.v"

module stopwatch_show ( /*input*/level,
    /*time*/ sec_ten, sec_uni, msec_ten, msec_uni,
    /*output*/ four_bcd, three_bcd, two_bcd, one_bcd );

    input [1:0] level;
    input [3:0] sec_ten, sec_uni, msec_ten, msec_uni;
    output reg [3:0] four_bcd, three_bcd, two_bcd, one_bcd;

    always@*
    begin
        if( level == `state_endless )
            begin
                four_bcd = sec_ten;
                three_bcd = sec_uni;
                two_bcd = msec_ten;
                one_bcd = msec_uni;
            end
        else
            begin
                four_bcd = 4'd13;
                three_bcd = 4'd12;
                two_bcd = 4'd11;
                one_bcd = 4'd4;
            end
    end
endmodule
