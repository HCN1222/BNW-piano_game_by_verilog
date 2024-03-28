`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 00:58:59
// Design Name: 
// Module Name: show_what
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


module     show_what ( /*input*/mode,
    /*level*/ level,
    /*volume*/ vol_ten, vol_uni,
    /*stw*/ stw_four, stw_three, stw_two, stw_one,
    /*output*/ four_bcd, three_bcd, two_bcd, one_bcd );

    input [1:0] mode;
    input [1:0] level;
    input [3:0] /*volume*/ vol_ten, vol_uni,/*stw*/ stw_four, stw_three, stw_two, stw_one;

    output reg [3:0] four_bcd, three_bcd, two_bcd, one_bcd;
    
    always@*
    begin
        if( mode == `state_game )
            begin
                four_bcd = stw_four;
                three_bcd = stw_three;
                two_bcd = stw_two;
                one_bcd = stw_one;
            end
        else if( mode == `state_volume )
            begin
                four_bcd = 4'd15;
                three_bcd = 4'd15;
                two_bcd = vol_ten;
                one_bcd = vol_uni;
            end
        else //mode == `state_level
            begin
                four_bcd = 4'd12; //L
                three_bcd = 4'd10; //V
                two_bcd = 4'd15;
                one_bcd = { 2'b0, level };
            end
    end

endmodule
